"""
Cache utilities for Daily Dashboard
Handles session-based caching of dashboard views for improved performance
"""

import os
import json
import pickle
import hashlib
from datetime import datetime, timedelta
from typing import Dict, Any, Optional
import pandas as pd
import streamlit as st

class DashboardCache:
    """Dashboard cache manager for session-based data storage"""
    
    def __init__(self, cache_dir: str = "cache/sessions"):
        """Initialize cache manager"""
        self.cache_dir = cache_dir
        self.ensure_cache_dir()
    
    def ensure_cache_dir(self):
        """Ensure cache directory exists"""
        if not os.path.exists(self.cache_dir):
            os.makedirs(self.cache_dir, exist_ok=True)
    
    def get_session_id(self) -> str:
        """Get or create session ID"""
        if 'session_id' not in st.session_state:
            # Create a unique session ID based on timestamp and random component
            timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
            import random
            random_suffix = random.randint(1000, 9999)
            st.session_state.session_id = f"session_{timestamp}_{random_suffix}"
        return st.session_state.session_id
    
    def get_session_dir(self) -> str:
        """Get session-specific cache directory"""
        session_id = self.get_session_id()
        session_dir = os.path.join(self.cache_dir, session_id)
        if not os.path.exists(session_dir):
            os.makedirs(session_dir, exist_ok=True)
        return session_dir
    
    def generate_cache_key(self, **kwargs) -> str:
        """Generate a unique cache key based on parameters"""
        # Create a sorted dictionary of parameters
        sorted_params = sorted(kwargs.items())
        param_string = json.dumps(sorted_params, sort_keys=True, default=str)
        
        # Generate hash of the parameters
        cache_key = hashlib.md5(param_string.encode()).hexdigest()
        return cache_key
    
    def get_cache_path(self, cache_key: str, data_type: str = "data") -> str:
        """Get full path for cache file"""
        session_dir = self.get_session_dir()
        return os.path.join(session_dir, f"{cache_key}_{data_type}.pkl")
    
    def save_data(self, data: Any, cache_key: str, data_type: str = "data", 
                  metadata: Optional[Dict] = None) -> bool:
        """Save data to cache"""
        try:
            cache_path = self.get_cache_path(cache_key, data_type)
            
            # Prepare cache entry
            cache_entry = {
                'data': data,
                'timestamp': datetime.now().isoformat(),
                'metadata': metadata or {}
            }
            
            # Save to pickle file
            with open(cache_path, 'wb') as f:
                pickle.dump(cache_entry, f)
            
            return True
        except Exception as e:
            st.error(f"Failed to save cache: {e}")
            return False
    
    def load_data(self, cache_key: str, data_type: str = "data", 
                  max_age_hours: int = 24) -> Optional[Any]:
        """Load data from cache if it exists and is not expired"""
        try:
            cache_path = self.get_cache_path(cache_key, data_type)
            
            if not os.path.exists(cache_path):
                return None
            
            # Load cache entry
            with open(cache_path, 'rb') as f:
                cache_entry = pickle.load(f)
            
            # Check if cache is expired
            cache_time = datetime.fromisoformat(cache_entry['timestamp'])
            if datetime.now() - cache_time > timedelta(hours=max_age_hours):
                # Cache expired, remove file
                os.remove(cache_path)
                return None
            
            return cache_entry['data']
        except Exception as e:
            # If there's an error loading cache, remove the corrupted file
            try:
                if os.path.exists(cache_path):
                    os.remove(cache_path)
            except:
                pass
            return None
    
    def get_cache_info(self, cache_key: str, data_type: str = "data") -> Optional[Dict]:
        """Get cache metadata without loading the full data"""
        try:
            cache_path = self.get_cache_path(cache_key, data_type)
            
            if not os.path.exists(cache_path):
                return None
            
            # Load cache entry
            with open(cache_path, 'rb') as f:
                cache_entry = pickle.load(f)
            
            return {
                'timestamp': cache_entry['timestamp'],
                'metadata': cache_entry.get('metadata', {}),
                'file_size': os.path.getsize(cache_path)
            }
        except Exception as e:
            return None
    
    def clear_session_cache(self):
        """Clear all cache for current session"""
        try:
            session_dir = self.get_session_dir()
            if os.path.exists(session_dir):
                import shutil
                shutil.rmtree(session_dir)
                st.success("Session cache cleared successfully!")
        except Exception as e:
            st.error(f"Failed to clear session cache: {e}")
    
    def clear_old_sessions(self, max_age_days: int = 7):
        """Clear cache for sessions older than specified days"""
        try:
            if not os.path.exists(self.cache_dir):
                return
            
            cutoff_time = datetime.now() - timedelta(days=max_age_days)
            
            for session_folder in os.listdir(self.cache_dir):
                session_path = os.path.join(self.cache_dir, session_folder)
                if os.path.isdir(session_path):
                    # Check if session folder is older than cutoff
                    folder_time = datetime.fromtimestamp(os.path.getctime(session_path))
                    if folder_time < cutoff_time:
                        import shutil
                        shutil.rmtree(session_path)
        except Exception as e:
            st.error(f"Failed to clear old sessions: {e}")
    
    def get_session_stats(self) -> Dict:
        """Get statistics about current session cache"""
        try:
            session_dir = self.get_session_dir()
            if not os.path.exists(session_dir):
                return {'file_count': 0, 'total_size': 0, 'files': []}
            
            files = []
            total_size = 0
            
            for filename in os.listdir(session_dir):
                if filename.endswith('.pkl'):
                    file_path = os.path.join(session_dir, filename)
                    file_size = os.path.getsize(file_path)
                    file_time = datetime.fromtimestamp(os.path.getmtime(file_path))
                    
                    files.append({
                        'name': filename,
                        'size': file_size,
                        'modified': file_time.isoformat()
                    })
                    total_size += file_size
            
            return {
                'file_count': len(files),
                'total_size': total_size,
                'files': files
            }
        except Exception as e:
            return {'error': str(e)}

# Global cache instance
dashboard_cache = DashboardCache()

def get_cache_key_for_dashboard(platform: str, start_date: str, end_date: str, 
                               operators: list, drilldown_level: str = "operator",
                               selected_operator: str = None, selected_store: str = None) -> str:
    """Generate cache key for dashboard state"""
    return dashboard_cache.generate_cache_key(
        platform=platform,
        start_date=start_date,
        end_date=end_date,
        operators=operators,
        drilldown_level=drilldown_level,
        selected_operator=selected_operator,
        selected_store=selected_store
    )

def save_dashboard_view(data: Dict[str, Any], cache_key: str):
    """Save complete dashboard view to cache"""
    metadata = {
        'saved_at': datetime.now().isoformat(),
        'data_types': list(data.keys())
    }
    return dashboard_cache.save_data(data, cache_key, "dashboard_view", metadata)

def load_dashboard_view(cache_key: str) -> Optional[Dict[str, Any]]:
    """Load dashboard view from cache"""
    return dashboard_cache.load_data(cache_key, "dashboard_view", max_age_hours=24)

def save_kpi_data(data: Dict[str, Any], cache_key: str):
    """Save KPI data to cache"""
    return dashboard_cache.save_data(data, cache_key, "kpi_data")

def load_kpi_data(cache_key: str) -> Optional[Dict[str, Any]]:
    """Load KPI data from cache"""
    return dashboard_cache.load_data(cache_key, "kpi_data", max_age_hours=24)

def save_operator_data(data: pd.DataFrame, cache_key: str):
    """Save operator data to cache"""
    return dashboard_cache.save_data(data, cache_key, "operator_data")

def load_operator_data(cache_key: str) -> Optional[pd.DataFrame]:
    """Load operator data from cache"""
    return dashboard_cache.load_data(cache_key, "operator_data", max_age_hours=24)

def save_store_data(data: pd.DataFrame, cache_key: str):
    """Save store data to cache"""
    return dashboard_cache.save_data(data, cache_key, "store_data")

def load_store_data(cache_key: str) -> Optional[pd.DataFrame]:
    """Load store data from cache"""
    return dashboard_cache.load_data(cache_key, "store_data", max_age_hours=24)

def save_campaign_data(data: pd.DataFrame, cache_key: str):
    """Save campaign data to cache"""
    return dashboard_cache.save_data(data, cache_key, "campaign_data")

def load_campaign_data(cache_key: str) -> Optional[pd.DataFrame]:
    """Load campaign data from cache"""
    return dashboard_cache.load_data(cache_key, "campaign_data", max_age_hours=24)

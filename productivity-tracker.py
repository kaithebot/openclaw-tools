#!/usr/bin/env python3
"""
AI Productivity Tracker - Self Development Project
Tracks work sessions, productivity metrics, and generates insights
"""

import json
import os
from datetime import datetime, timedelta
from pathlib import Path

class ProductivityTracker:
    def __init__(self):
        self.data_file = Path.home() / ".openclaw" / "productivity.json"
        self.data = self.load_data()
    
    def load_data(self):
        if self.data_file.exists():
            with open(self.data_file, 'r') as f:
                return json.load(f)
        return {"sessions": [], "tasks": [], "goals": {}}
    
    def save_data(self):
        self.data_file.parent.mkdir(parents=True, exist_ok=True)
        with open(self.data_file, 'w') as f:
            json.dump(self.data, f, indent=2)
    
    def start_session(self, project, task_type):
        session = {
            "start": datetime.now().isoformat(),
            "project": project,
            "type": task_type,
            "status": "active"
        }
        self.data["sessions"].append(session)
        self.save_data()
        return f"✅ Started tracking: {project} - {task_type}"
    
    def end_session(self, notes=""):
        if not self.data["sessions"] or self.data["sessions"][-1]["status"] != "active":
            return "❌ No active session to end"
        
        session = self.data["sessions"][-1]
        session["end"] = datetime.now().isoformat()
        session["status"] = "completed"
        session["notes"] = notes
        
        # Calculate duration
        start = datetime.fromisoformat(session["start"])
        end = datetime.fromisoformat(session["end"])
        duration = (end - start).total_seconds() / 3600  # hours
        session["duration_hours"] = round(duration, 2)
        
        self.save_data()
        return f"✅ Session ended. Duration: {duration:.2f} hours"
    
    def get_stats(self, days=7):
        cutoff = datetime.now() - timedelta(days=days)
        recent_sessions = [
            s for s in self.data["sessions"]
            if datetime.fromisoformat(s["start"]) > cutoff
            and s.get("status") == "completed"
        ]
        
        total_hours = sum(s.get("duration_hours", 0) for s in recent_sessions)
        projects = {}
        for s in recent_sessions:
            proj = s["project"]
            projects[proj] = projects.get(proj, 0) + s.get("duration_hours", 0)
        
        return {
            "total_sessions": len(recent_sessions),
            "total_hours": round(total_hours, 2),
            "avg_session": round(total_hours / len(recent_sessions), 2) if recent_sessions else 0,
            "projects": {k: round(v, 2) for k, v in projects.items()}
        }
    
    def report(self):
        stats = self.get_stats()
        report = f"""
📊 PRODUCTIVITY REPORT (Last 7 Days)
=====================================
Total Sessions: {stats['total_sessions']}
Total Hours: {stats['total_hours']}
Average Session: {stats['avg_session']} hours

Projects Breakdown:
"""
        for project, hours in stats['projects'].items():
            report += f"  • {project}: {hours} hours\n"
        
        return report

if __name__ == "__main__":
    tracker = ProductivityTracker()
    import sys
    
    if len(sys.argv) < 2:
        print(tracker.report())
    elif sys.argv[1] == "start":
        print(tracker.start_session(sys.argv[2], sys.argv[3]))
    elif sys.argv[1] == "end":
        notes = " ".join(sys.argv[2:]) if len(sys.argv) > 2 else ""
        print(tracker.end_session(notes))
    elif sys.argv[1] == "report":
        print(tracker.report())

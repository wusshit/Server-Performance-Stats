#  Server Performance Stats
A bash script to analyse basic server performance stats and login info

This script provides several system monitoring and diagnostic capabilities that are particularly useful in production environments for maintaining system health and security
## Output
1. Failed login attempts
2. Logged in users
3. OS info
4. Uptime & Load average
5. Total CPU usage
6. Total memory usage (Free vs Used including percentage)
7. Total disk usage (Free vs Used including percentage)
8. Top 5 processes by CPU usage
9. Top 5 processes by memory usage
### 1. Clone the repository
```bash
git clone https://github.com/wusshit/Server-Performance-Stats.git
cd Downloads/server-performance-stats 
```
### 2. Make the script executable
```bash
chmod +x server-stats.sh
```
### 3. Execute the script
```bash
./server-stats.sh
```
Part of this challenge: https://roadmap.sh/devops/projects

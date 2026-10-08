# SmartGroup Team Analyzer

A browser-based team planning and analysis demo with separate Team Leader and Team Member accounts.

## Run the browser-only demo

1. Extract this folder.
2. Open `index.html` in a current browser.
3. Choose **Create account** and select a role.
4. Create the first Team Leader account. The first leader sets a leader access code; additional leaders need that code.
5. Save the recovery key shown once after registration. Use **Forgot password?** on the sign-in form with your email, recovery key and new password. Older demo accounts receive a recovery key the next time they sign in.
6. To create a Team Member account, enter the member's name, email, skills, skill level and password. The new profile is added to the roster with those skills.

## Run with MySQL on your PC

The MySQL-backed mode uses the included Spring Boot API. Install and start **MySQL Server** (Workbench is the client used to manage it), then create the database in a Workbench query tab:

```sql
CREATE DATABASE smartgroup;
```

From the repository folder containing `pom.xml`, open PowerShell and set the MySQL credentials for that window. Replace `your MySQL password` with the password for your MySQL user; do not put it in this repository:

```powershell
$env:DB_USER="root"
$env:DB_PASSWORD="your MySQL password"
mvn spring-boot:run
```

Open `http://localhost:8080`. The app runs its `schema.sql` on startup and saves accounts, projects, members and tasks to MySQL. Registration creates a recovery key; save it because **Forgot password?** uses it to reset the database account password.

## What it includes

- Leader and member sign-up and sign-in screens, with recovery-key password reset.
- A dashboard, project list, task board, team roster and timeline.
- A refreshed dashboard with a welcome panel, progress ring, KPI cards, project progress, team capacity, upcoming tasks and smart alerts.
- Select any project card to open its project overview, including completion, schedule, health, risks and project facts; a member-by-member breakdown shows completed and unfinished work, followed by the full task register.
- Rule-based team analysis with team and individual pros/cons, skill coverage, workload, schedule estimates and project risks.
- A separate AI Suggester reviews all active projects and open work, then prioritizes actions for overdue or unassigned tasks, workload balance, missing project skills, projects without task plans, incomplete project goals/deadlines and project risks. Leaders can add members directly from skill and capacity recommendations. Its finish estimate uses task-priority effort assumptions and available team capacity.
- The AI Suggester shows completed/open task counts and its last-update time, refreshes from the latest workspace data, and syncs local changes from other open tabs.
- Project-card auto-assignment routes open tasks only to members marked Available, ranking skill match, experience level and workload. For projects with no tasks, **Create & assign** makes starter tasks from the project tech stack and assigns them to available skill matches; unmatched tasks remain unassigned.
- A local team assistant answers common questions about members, pros and cons, skills, capacity, tasks, deadlines, risks and projects, and explains how to use the app.
- Members can update the status of their own assigned tasks. Leaders can manage team members, projects and tasks.
- Members receive in-app bell notifications when tasks are assigned to them, including the task, project, priority and due date; notifications can be marked read.
- Light and dark teal themes, reminders and downloadable project analysis reports.

## Demo data and storage

The browser-only demo saves accounts and workspace data in that browser's local storage. MySQL-backed mode is available when the site is served by the local Spring Boot app at `http://localhost:8080`. GitHub Pages cannot connect to a MySQL Server running only on your PC; a live shared site needs a hosted backend and database. Team analysis and assistant responses use local rules, do not call an external AI service, and cannot answer live or unrelated world-knowledge questions.

The starter workspace opens with sample members, projects and tasks. Create a leader account first to explore the management controls.


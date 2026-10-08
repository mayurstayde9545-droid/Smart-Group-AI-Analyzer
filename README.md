# SmartGroup Team Analyzer

A browser-based team planning and analysis demo with separate Team Leader and Team Member accounts.

## Run the browser-only demo

1. Extract this folder.
2. Open `index.html` in a current browser.
3. Choose **Create account** and select a role.
4. Create the first Team Leader account. The first leader sets a leader access code; additional leaders need that code.
5. Save the recovery key shown once after registration. Use **Forgot password?** on the sign-in form with your email, recovery key and new password. Older demo accounts receive a recovery key the next time they sign in.
6. To create a Team Member account, enter the member's name, email, skills, skill level and password. The new profile is added to the roster with those skills.


## Run the full app with Docker Desktop

Docker Compose runs the Spring Boot app and a separate MySQL container. You do not need Maven or MySQL Server installed on your PC; Docker Desktop must be open and its engine running.

1. Copy `.env.example` to `.env` and replace both example passwords with private values. Do not commit `.env` to GitHub.
2. If the app is already running from a JAR in another PowerShell window, stop it with **Ctrl+C** so Docker can use port 8080.
3. In PowerShell, from the folder containing `compose.yaml`, run:

   ```powershell
   docker compose up --build
   ```

4. Open `http://localhost:8080`. Docker creates the tables at startup and stores its database in a persistent volume.

To stop the containers, press **Ctrl+C** and run `docker compose down`. The Docker MySQL database is separate from a MySQL Server already installed on your PC. In Workbench, connect to host `127.0.0.1`, port `3307`, database `smartgroup`, and the `DB_USER`/`DB_PASSWORD` values from `.env` to view the Docker database.

### Connect Docker to the MySQL Server already on this PC

If you want the Docker app to use your existing PC database instead of creating a separate MySQL container:

1. In MySQL Workbench, create the `smartgroup` database if needed and create a dedicated app user. Replace the password placeholder with a private password:

   ```sql
   CREATE DATABASE IF NOT EXISTS smartgroup;
   CREATE USER 'smartgroup_app'@'%' IDENTIFIED BY 'choose-a-private-password';
   GRANT ALL PRIVILEGES ON smartgroup.* TO 'smartgroup_app'@'%';
   ```

2. Copy `.env.example` to `.env`. Set `DB_USER=smartgroup_app`, set `DB_PASSWORD` to the password you chose, and keep `DB_URL` pointing at `host.docker.internal`. Do not commit `.env`.
3. Ensure MySQL Server is running and permits connections from Docker Desktop. If the connection fails, check that MySQL is listening on the host network interface and that Windows Firewall permits local Docker Desktop connections.
4. Stop the old JAR if it uses port 8080, then run this from the repository folder:

   ```powershell
   docker compose -f compose.host-db.yaml up --build
   ```

This mode uses the same `smartgroup` database you can inspect in Workbench. Stop it with **Ctrl+C**. Use `compose.yaml` without the host-db option if you prefer a separate MySQL container.

## Run with MySQL on your PC

The MySQL-backed mode uses the included Spring Boot API. Install and start **MySQL Server** (Workbench is the client used to manage it), then create the database in a Workbench query tab:

```sql
CREATE DATABASE smartgroup;
```

From the repository folder containing `pom.xml`, open PowerShell and set the MySQL credentials for that window. Replace `your MySQL password` with the password for your MySQL user; do not put it in this repository:

```powershell
$env:DB_USER="root"
$env:DB_PASSWORD="your MySQL password"
.\mvnw.cmd spring-boot:run
```

The first run downloads the included Maven version automatically. Java 17 and an internet connection are required.

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

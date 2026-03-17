You are a senior frontend developer.

Build a modern Admin Dashboard chart using React + Tailwind + Recharts.

=====================
FEATURE: LOGIN ACTIVITY (LAST 7 DAYS)
=====================

Create a responsive Line Chart showing student login activity for the last 7 days.

REQUIREMENTS:

1. CHART TITLE
- "Student Login Activity (Last 7 Days)"

2. DATA FORMAT
Use mock data like:
[
  { date: "Mon", users: 120 },
  { date: "Tue", users: 98 },
  { date: "Wed", users: 150 },
  { date: "Thu", users: 200 },
  { date: "Fri", users: 170 },
  { date: "Sat", users: 90 },
  { date: "Sun", users: 60 }
]

3. CHART DESIGN
- Use LineChart from Recharts
- Smooth line (type="monotone")
- Add dots on each point
- Tooltip on hover
- Grid lines (light)
- ResponsiveContainer

4. AXIS
- X-axis: Day (Mon → Sun)
- Y-axis: Number of students

5. STYLE
- Clean modern dashboard style
- Rounded card container
- Soft shadow
- Padding

6. BONUS
- Add dropdown filter:
  - "Today"
  - "Last 7 Days"
  - "Last 30 Days"

7. COMPONENT STRUCTURE
- Create component: LoginChart.jsx
- Export default component

8. OUTPUT
- Return full React component code
- No explanation
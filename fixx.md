You are a senior frontend engineer. Fix the UI and filtering logic for my job portal system.



==================== CONTEXT ====================

I have 2 pages:

1\. teacher-apply (job detail page)

2\. teacher-jobs (job listing page)



==================== TASK 1: FIX teacher-apply ====================



Current issue:

\- In the job description, requirements, and benefits sections, content is displayed in a single line separated by "-" characters.

\- This makes the UI hard to read.



Example current:

"MÔ TẢ CÔNG VIỆC: - Phát triển backend - Thiết kế API - Làm việc với database"



Expected:

Each "-" must be rendered as a new bullet line.



Fix requirements:

\- Split content by "-" into multiple lines

\- Render as a vertical list (ul/li or separate divs)

\- Remove empty items

\- Trim spaces



Example expected UI:

• Phát triển backend  

• Thiết kế API  

• Làm việc với database  



Implementation suggestion:

\- Use `.split('-')`

\- Map to JSX elements



Example:

const formatList = (text) => {

&#x20; return text

&#x20;   .split('-')

&#x20;   .map(item => item.trim())

&#x20;   .filter(item => item.length > 0);

};



Then render:

<ul>

&#x20; {formatList(description).map((item, index) => (

&#x20;   <li key={index}>{item}</li>

&#x20; ))}

</ul>



Apply this for:

\- Job Description

\- Job Requirements

\- Benefits



==================== TASK 2: FIX teacher-jobs ====================



Current issue:

\- Dropdown "All Employment Types" is meaningless

\- It does not reflect actual job grouping



New requirement:

\- Replace "Employment Types" filter with "Job Category"

\- Jobs must be grouped and filterable by category



Example categories:

\- Backend Developer

\- Frontend Developer

\- Fullstack Developer

\- Teaching Role



==================== IMPLEMENTATION ====================



1\. Add category field to each job:

{

&#x20; title: "Backend Developer",

&#x20; category: "Backend"

}



2\. Replace dropdown:

"All Employment Types" → "All Categories"



3\. Extract unique categories:

const categories = \["All", ...new Set(jobs.map(job => job.category))];



4\. Add filter state:

const \[selectedCategory, setSelectedCategory] = useState("All");



5\. Filter jobs:

const filteredJobs = selectedCategory === "All"

&#x20; ? jobs

&#x20; : jobs.filter(job => job.category === selectedCategory);



6\. Update UI dropdown:

<select onChange={(e) => setSelectedCategory(e.target.value)}>

&#x20; {categories.map(cat => (

&#x20;   <option key={cat} value={cat}>{cat}</option>

&#x20; ))}

</select>



7\. Render filtered jobs instead of full list



==================== UI IMPROVEMENT ====================

\- Keep existing design (cards, spacing, buttons)

\- Only change logic + text label

\- Ensure responsive layout

\- Add smooth UX (optional highlight active category)



==================== OUTPUT ====================

Return:

\- Clean React code (or JSX)

\- Refactored components if needed

\- No explanation, only code


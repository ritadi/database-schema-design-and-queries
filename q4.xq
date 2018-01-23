declare variable $dataset0 external;
declare variable $dataset1 external;

<bestskills>{
let $interview := $dataset0
let $resume := $dataset1
for $i in $interview/interviews
let $highest := max($i/accessment/communication,$i/accessment/enthusiasm,$i/accessment/collegiality)
let $skills :=
    for $r in $resume/resumes
    where $r/@rID = $i/@rID
    return $r/skills/@what
for $s in $skills
let $result := $s
where $s = $i/accessment/techProficiency
return ($r/identification/name/forename,$i/@sID,$highest)
}</bestskills>

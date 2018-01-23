declare variable $dataset0 external;

<qualified>{
let $d := $dataset0/resumes
for $r in $d
let $skills := $r/skills
where count($r/skills/skill/@what) > 3
return ($r/@rID,$r/identification/name/forename,count($r/skills/skill/@what),$r/identification/citizenship)
}</qualified>

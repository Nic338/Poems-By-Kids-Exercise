--What grades are stored in the database?
select *
from Grade

--What emotions may be associated with a poem?
select * from Emotion

--How many poems are in the database?
select Count(Poem.Id)
from Poem

--Sort authors alphabetically by name. What are the names of the top 76 authors?
select top 76 Author.Name
from Author
order by Author.Name asc

--Starting with the above query, add the grade of each of the authors.
select top 76 Author.Name, Grade.Name
from Author
join Grade on Grade.Id = Author.GradeId
order by Author.Name asc

--Starting with the above query, add the recorded gender of each of the authors.
select top 76 Author.Name, Grade.Name, Gender.Name
from Author
join Grade on Grade.Id = Author.GradeId
join Gender on Gender.Id = Author.GenderId
order by Author.Name asc

--What is the total number of words in all poems in the database?
select Sum(Poem.WordCount)
from Poem

--Which poem has the fewest characters?
select top 1 Poem.Title, Poem.CharCount
from Poem
order by Poem.CharCount

--How many authors are in the third grade?
select count(Author.GradeId) as '3rd Grade Authors'
from Author
join Grade on Grade.Id = Author.GradeId
where Grade.Name = '3rd Grade'

--How many total authors are in the first through third grades?
select count(Author.GradeId) as '1st-3rd Grade Authors'
from Author
join Grade on Grade.Id = Author.GradeId
where Grade.Name in ('1st Grade','2nd Grade','3rd Grade')

--What is the total number of poems written by fourth graders?
select count(Poem.AuthorId) as '4th Grade Poets'
from Poem
join Author on Author.Id = Poem.AuthorId
join Grade on Grade.Id = Author.GradeId
where Grade.Name = '4th Grade'

--How many poems are there per grade?
select Grade.Name, count(Poem.Id) as 'Poems per Grade'
from Grade
join Author on Author.GradeId = Grade.Id
join Poem on Poem.AuthorId = Author.Id
group by Grade.Name

--How many authors are in each grade? (Order your results by grade starting with 1st Grade)
select Grade.Name, count(Author.Id) as 'Authors per Grade'
from Grade
join Author on Author.GradeId = Grade.Id
group by Grade.Name

--What is the title of the poem that has the most words?
select top 1 Poem.Title, Poem.WordCount
from Poem
order by Poem.WordCount desc

--Which author(s) have the most poems? (Remember authors can have the same name.)
select Author.Name, count(Poem.Id)
from Author
join Poem on Author.Id = Poem.AuthorId
group by Author.Name
order by count(Poem.Id) desc

--How many poems have an emotion of sadness?
select count(Poem.Id) as 'Sad Poems'
from Poem
join PoemEmotion on Poem.Id = PoemEmotion.PoemId
join Emotion on Emotion.Id = PoemEmotion.EmotionId
where Emotion.Name = 'Sadness'

--How many poems are not associated with any emotion?
select count(Poem.Id) as 'Emotionless Poems'
from Poem
join PoemEmotion on Poem.Id = PoemEmotion.PoemId
join Emotion on Emotion.Id = PoemEmotion.EmotionId
where PoemEmotion.EmotionId is null

--Which emotion is associated with the least number of poems?
select top 1 Emotion.Name, count(Poem.Id) as 'Least Emoted Poems'
from Poem
join PoemEmotion on Poem.Id = PoemEmotion.PoemId
join Emotion on Emotion.Id = PoemEmotion.EmotionId
group by Emotion.Name
order by count(EmotionId)

--Which grade has the largest number of poems with an emotion of joy?
select top 1 Grade.Name, count(Poem.Id) as 'Poem Count'
from Grade
join Author on Grade.Id = Author.GradeId
join Poem on Author.Id = Poem.AuthorId
join PoemEmotion on Poem.Id = PoemEmotion.PoemId
join Emotion on Emotion.Id = PoemEmotion.EmotionId
where Emotion.Name = 'Joy'
group by Grade.Name
order by count(Poem.Id) desc

--Which gender has the least number of poems with an emotion of fear?
select top 1 Gender.Name, count(Poem.Id) as 'Poem Count'
from Gender
join Author on Gender.Id = Author.GenderId
join Poem on Author.Id = Poem.AuthorId
join PoemEmotion on Poem.Id = PoemEmotion.PoemId
join Emotion on Emotion.Id = PoemEmotion.EmotionId
where Emotion.Name = 'Fear'
group by Gender.Name
order by count(Poem.Id) asc
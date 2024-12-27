SELECT * FROM movies.imdb_movies;

# Movies released in a specific year (2016)

SELECT 
    *
FROM
    imdb_movies
WHERE
    year = 2016;
    
# Top 10 movies by rating

SELECT 
    *
FROM
    imdb_movies
ORDER BY Rating DESC
LIMIT 10;

# All unique genres

SELECT DISTINCT
    (genre)
FROM
    imdb_movies;
    
# Movies with a runtime greater than 120 minutes
    
SELECT 
    *
FROM
    imdb_movies
WHERE
    Runtime_Minutes > 120;
    
# Number of movies for each director
    
SELECT 
    director, COUNT(title) AS movies_count
FROM
    imdb_movies
GROUP BY Director;

# Average rating of movies by genre

SELECT 
    genre, ROUND(AVG(rating), 0)
FROM
    imdb_movies
GROUP BY genre;

# Movies where the revenue is greater than $100 million

SELECT 
    *
FROM
    imdb_movies
WHERE
    Revenue_USD > 100000000;
    
# Movies with a meta score greater than 70
    
SELECT 
    *
FROM
    imdb_movies
WHERE
    Metascore > 70;
    
# Number of movies released in each decade
    
SELECT 
    c.decade, COUNT(year) AS movies_count
FROM
    (SELECT 
        year,
            CASE
                WHEN year >= 2001 AND year <= 2010 THEN '2001 - 2010'
                WHEN year >= 2011 AND year <= 2020 THEN '2011 - 2020'
            END AS decade
    FROM
        imdb_movies) AS c
GROUP BY decade;

#  Movie with the highest revenue in USD

SELECT 
    *
FROM
    imdb_movies
ORDER BY Revenue_USD DESC
LIMIT 1;

# Average runtime of movies for each genre

SELECT 
    genre, AVG(runtime_minutes) AS avg_runtime
FROM
    imdb_movies
GROUP BY genre;

# Movies where rating is above average

SELECT 
    *
FROM
    imdb_movies
WHERE
    rating > (SELECT 
            AVG(rating)
        FROM
            imdb_movies)
            
# Number of movies released in each year

Select year, count(title) as movies_counts
from imdb_movies
group by year;

# Top 5 directors with the highest average ratings

SELECT 
    director, ROUND(AVG(rating), 1) AS avg_rating
FROM
    imdb_movies
GROUP BY Director
ORDER BY avg_rating DESC
LIMIT 5;

# Movies that have received more than 100,000 votes

SELECT 
    *
FROM
    imdb_movies
WHERE
    votes > 100000;
    
# Longest and shortest movie runtime

SELECT 
    MAX(runtime_minutes) AS longest_runtime,
    MIN(runtime_minutes) AS shortest_runtime
FROM
    imdb_movies;
    
# Movies by a specific director (Christopher Nolan)
    
SELECT 
    *
FROM
    imdb_movies
WHERE
    Director = '"Christopher Nolan"'
    
# Average meta score of movies by release year

Select year, round(avg(metascore),2) as avg_metascore
from imdb_movies
group by year
order by year;

# Highest rated movie for each genre

SELECT 
    title, genre, MAX(rating) AS highest_rated
FROM
    imdb_movies
GROUP BY title , genre;

# Director with the highest average revenue

SELECT 
    director, AVG(revenue_usd) AS avg_revenue
FROM
    imdb_movies
GROUP BY Director
ORDER BY avg_revenue DESC
LIMIT 1;

# Movies that have a revenue-to-runtime ratio greater than 1 million per minute

SELECT 
    title, FORMAT(revenue_to_runtime, 0) AS revenue_to_runtime
FROM
    (SELECT 
        title, (revenue_usd / runtime_minutes) AS revenue_to_runtime
    FROM
        imdb_movies) AS c
WHERE
    revenue_to_runtime > 1000000;
    
# Genre with the highest average rating and its corresponding average rating
    
SELECT 
    genre, AVG(rating) AS avg_rating
FROM
    imdb_movies
GROUP BY genre
ORDER BY avg_rating DESC
LIMIT 1;

# Top 3 highest-grossing movies by their revenue and order them by revenue

SELECT 
    title, revenue_usd
FROM
    imdb_movies
ORDER BY Revenue_USD DESC
LIMIT 3;

# Most recent movie for each genre

SELECT DISTINCT
    (genre), MAX(year) AS recent_movie
FROM
    imdb_movies
GROUP BY genre;

# Director with the most diverse genres

SELECT 
    director, COUNT(DISTINCT genre) AS genre_count
FROM
    imdb_movies
GROUP BY Director
ORDER BY genre_count DESC
LIMIT 1;

# Movie with the highest difference between rating and meta score

SELECT 
    title, ROUND((rating - metascore), 0) AS difference
FROM
    imdb_movies
ORDER BY difference DESC
LIMIT 1;

# Top 5 genres with the highest average revenue

SELECT 
    genre, ROUND(AVG(revenue_usd), 0) AS avg_revenue
FROM
    imdb_movies
GROUP BY genre
ORDER BY avg_revenue DESC
LIMIT 5;

# Average rating for each director, considering only movies with at least 500 votes

SELECT 
    director, AVG(rating) AS avg_rating
FROM
    imdb_movies
WHERE
    votes >= 500
GROUP BY Director;

# Top 5 most profitable movies based on revenue vs. runtime (revenue per minute)

SELECT 
    title,
    revenue_usd,
    Runtime_Minutes,
    ROUND((revenue_usd / runtime_minutes), 0) AS revenue_per_minute
FROM
    imdb_movies
ORDER BY revenue_per_minute DESC
LIMIT 5;

# Movie(s) with the highest number of votes and its corresponding rating

SELECT 
    title, rating, votes
FROM
    imdb_movies
WHERE
    votes = (SELECT 
            MAX(votes)
        FROM
            imdb_movies);
 
 # Top 3 highest-rated movies that are under 90 minutes runtime
 
SELECT 
    title, Rating, runtime_minutes
FROM
    imdb_movies
WHERE
    Runtime_Minutes < 90
ORDER BY rating DESC
LIMIT 3;

# Revenue generated by movies in each decade

SELECT 
    decade, FORMAT(SUM(Revenue_USD), 0) AS total_revenue
FROM
    (SELECT 
        Revenue_USD,
            year,
            CASE
                WHEN year >= 2001 AND year <= 2010 THEN '2001 - 2010'
                WHEN year >= 2011 AND year <= 2020 THEN '2011 - 2020'
            END AS decade
    FROM
        imdb_movies) AS c
GROUP BY decade;

# Top 10 highest-grossing movies of all time

SELECT 
    title, FORMAT(revenue_usd, 0) AS highest_grossing
FROM
    imdb_movies
ORDER BY Revenue_USD DESC
LIMIT 10;

# Top 10 movies ranked based on revenue

select * from (Select title, format(Revenue_USD,0) as revenue,
dense_rank() over(order by Revenue_usd desc) as ranks
from imdb_movies) as c
where ranks < 11;

# Average runtime for movies in each genre

SELECT 
    genre, ROUND(AVG(runtime_minutes), 2) AS avg_runtime
FROM
    imdb_movies
GROUP BY genre;

# Director who has directed the most movies

SELECT 
    director, COUNT(title) AS movie_count
FROM
    imdb_movies
GROUP BY Director
ORDER BY movie_count DESC
LIMIT 1;

# Movies that have a higher rating than the average rating of all movies

SELECT 
    title, rating
FROM
    imdb_movies
WHERE
    rating > (SELECT 
            AVG(rating) AS avg_rating
        FROM
            imdb_movies);
            
# Movies that were released in the same year as the highest-grossing movie of all time.
            
SELECT 
    title, year, FORMAT(Revenue_USD,0) AS revenue
FROM
    imdb_movies
WHERE
    year = (SELECT 
            year
        FROM
            imdb_movies
        ORDER BY Revenue_USD DESC
        LIMIT 1);
        
# Average rating and revenue for movies directed by 'James Gunn'

SELECT 
    FORMAT(AVG(revenue_usd), 0) AS avg_revenue,
    ROUND(AVG(rating), 2) AS avg_rating
FROM
    imdb_movies
WHERE
    Director = '"James Gunn"';
    

# Movies that have a metascore higher than the average metascore for their genre    
    
With c as
(select genre, round(avg(metascore),0) as avg_metascore
from imdb_movies
group by genre) 

select title, metascore, c.avg_metascore
from imdb_movies
join c  on imdb_movies.genre = c.genre
where metascore > c.avg_metascore;

# Top 3 most popular actors based on the number of votes their movies have received

select * from (select actors, format(sum(votes),0) as total_votes,
dense_rank() over (order by sum(votes) desc) as ranks
from imdb_movies
group by actors) as c 
where c.ranks < 4;

# Movies that have a runtime longer than the average runtime of movies released in the same year

with c as (Select year, round(avg(runtime_minutes),2) as avg_runtime
from imdb_movies
group by year)

select title, runtime_minutes, c.avg_runtime
from imdb_movies
join c on imdb_movies.year = c.year
where runtime_minutes > c.avg_runtime;

#  Movies with the word "Drama" in their genre.

SELECT 
    title, genre
FROM
    imdb_movies
WHERE
    genre LIKE '"%Drama%"';
    
# Movies directed by a director whose name starts with "Steven"

SELECT 
    title, director
FROM
    imdb_movies
WHERE
    Director LIKE '"Steven%"';
    
 # Movies where the actor's name contains the substring "Will"
 
SELECT 
    title, Actors
FROM
    imdb_movies
WHERE
    Actors LIKE '"%Will%"';
    
# Movies with a title that starts with the letter "T"

SELECT 
    title
FROM
    imdb_movies
WHERE
    title LIKE '"T%"'
 
# Movies where the director's name ends with "son"

SELECT 
    title, DIRECTOR
FROM
    imdb_movies
WHERE
    DIRECTOR LIKE '"%SON"'
    
# Movies where the actor's name starts with "John" and ends with "Goodman"    

SELECT 
    title, actors
FROM
    imdb_movies
WHERE
    ACTORs LIKE '"%John%Goodman%"';
    
# Movies where the genre starts with "Sci" and ends with "Fi"
    
SELECT 
    title, genre
FROM
    imdb_movies
WHERE
    genre LIKE '"%Sci%Fi%"';
    
# Movies where the director's name is exactly 10 characters long

SELECT 
    title, Director
FROM
    imdb_movies
WHERE
    length(DIRECTOR) = 12;

    

    


    


    





    

    

    


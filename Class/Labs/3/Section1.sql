INSERT INTO `genre`
values (
		default,
        'Fantasy'),
        (
		default,
        'Family Film'
        );

select * from genre;

insert into `creator`
values (
		default,
        'George',
        'Lucas'),
        (
		default,
        'John',
        'Lasseter'),
        (
		default,
        'John',
        'Tolkien');
        
select * from creator;

insert into `movie_series`
values (
		default,
        1,
        1,
        'Star Wars',
        129.99),
        (
		default,
        2,
        2,
        'Toy Story',
        22.13),
        (
		default,
        1,
        3,
        'Lord of the Rings',
        null),
        (
		default,
        2,
        2,
        'Cars',
        24.99);
        
select * from movie_series;

update movie_series
set suggested_price = 22.13 
where movie_series_id = 2;

insert into `movie`
values (
		default,
        1,
        'Episode I: The Phantom Menace',
        136
        ),
        (
		default,
        1,
        'Episode II: Attack of the Clones',
        142
        ),
        (
		default,
        1,
        'Episode III: Revenge of the Sith',
        140
        ),
        (
		default,
        1,
        'Episode IV: A New Hope',
        121
        ),
        (
		default,
        2,
        'Toy Story',
        121
        ),
        (
		default,
        2,
        'Toy Story 2',
        135
        ),
        (
		default,
        2,
        'Toy Story 3',
        148
        ),
        (
		default,
        3,
        'The Lord of the Rings: The Fellowship of the Ring',
        228
        ),
        (
		default,
        3,
        'The Lord of the Rings: The Two Towers',
        235
        ),
        (
		default,
        3,
        'The Lord of the Rings: The Return of the King',
        200
        ),
        (
		default,
        4,
        'Cars 1',
        117
        ),
        (
		default,
        4,
        'Cars 2',
        106
        );
        
select * from movie;

select count(*) as `available_movie` from movie;

select * 
from movie_series
where suggested_price = (select max(suggested_price)
						 from movie_series);
                         
select * 
from movie_series
where suggested_price = (select min(suggested_price)
						 from movie_series);
                         

select 
		ms.series_name, 
        ms.suggested_price, 
        count(m.movie_id) as `movie_count`
from movie_series ms
join movie m using (movie_series_id)
group by ms.series_name;

select 
		g.genre_name,
        count(*) as `Movie_count`
from movie m
join movie_series ms using (movie_series_id)
join genre g using (genre_id)
group by g.genre_name
having count(m.movie_id) >= 7;


select 
		series_name, 
        movie_name, 
        concat(floor((length_in_minutes/60)),'hr ',(length_in_minutes%60),'m') as `movie_duration`
from movie m
join movie_series ms using (movie_series_id)
where movie_series_id = (
							select 
									movie_series_id
							from movie m
							join movie_series ms using (movie_series_id)
							group by series_name
							having sum(length_in_minutes) >= 600
						);


select 
		concat(first_name,' ',last_name) as `name`,
        count(movie_id)
from creator
cross join movie_series ms using(creator_id)
cross join movie using(movie_series_id)
where ms.genre_id = 2 
group by `name`;


select 
        count(movie_id) as `movie_count`
from genre g
join movie_series ms using (genre_id)
join movie using(movie_series_id)
group by genre_name;

select
		concat(first_name, ' ', last_name) as `name`,
        count(movie_id) as `family_film`
from movie_series ms
join movie m using(movie_series_id)
join genre g on ms.genre_id = g.genre_id and genre_name = 'Family Film'
right join creator c using(creator_id)
group by `name`
order by `family_film` desc




 























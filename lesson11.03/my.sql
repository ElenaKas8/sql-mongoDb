--https://western-appeal-39b.notion.site/GenTech-190923-m-be-m-fe-m-qa-ed7e7a76535646e0a5fe8daf9f27c866
--https://www.w3schools.com/mysql/trymysql.asp?filename=trysql_select_all

--hw 
--1 Вывести данные об одном треке (на ваш выбор)

--2 Вывести данные клиентов из Germany (в проекции - без страны)

--3 Вывести данные о треках (в проекции - без первичного ключа)

--4 Вывести страны и имена всех клиентов


--# Операторы сравнения в MongoDB

`$eq` равно (equal)

`$ne` не равно (not equal)

`$gt` больше (greater than)

`$gte` больше или равно (greater than or equal)

`$lt` меньше (less than)

`$lte` меньше или равно (less than or equal)

--Задача. Вывести названия всех треков
db.tracks.find( {}, {title: 1,_id:0} )


--Задача. Вывести названия треков, длительность которых больше 120 секунд
db.tracks.find( {duration_secs: {$gt: 120} }, {title: 1,_id:0} )

--**Задача. Вывести данные о треках**

--проекция: `все поля, кроме продолжительности`

db.tracks.find( {}, { duration_secs: 0} )


--Пример. Вывести треки продолжительностью 5 мин и более
db.tracks.find(
    { duration_secs: { $gte: 5 * 60 } }
)

--**Задача. Вывести треки продолжительностью до одного часа (вкл.)**

(проекция: `название_трека`, `продолжительность_трека`)

db.tracks.find(
    { duration_secs: { $lte: 60 * 60 } },
    { title: 1, duration_secs: 1,_id:0 }
)


--Задача. Вывести юзеров не из Germany

db.users.find(
    { country: { $ne: "Germany" } },
    { fullname: 1, _id: 0 }
)


--вывести промежуточное значение 
db.tracks.find(
    { duration_secs: { 
        $gte: 5 * 60, $lte: 10 * 60 
        } 
    }
)

Пример. Вывести юзеров из Germany и France
db.users.find(
    {
        country: { $in: ['Germany', 'France'] }
    }
)
​
--Задача. Вывести юзеров не из USA и не из UK, имена которых не Ivan Ivanov

db.users.find(
    {
        country: { $nin: ['USA', 'UK'] },
        fullname: { $ne: 'Ivan Ivanov' }
    }
)

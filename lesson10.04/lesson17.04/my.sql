--https://western-appeal-39b.notion.site/GenTech-17-Apr-17-2024-51431e9570a44cd3a2d288af5cdc7c92


 --DZ-1 уровень сложности: 1. Завершите описание схемы БД “Приложение доставки блюд из ресторанов”.

--В рамках БД 190923_MUSIC напишите следующие запросы:



--2.Вывести общее ко-во реакций, используя метод aggregate()

--3.Вывести данные о реакциях, включая название трека и имя автора

db.reactions.aggregate([

    {
        $lookup: {
            from: 'tracks',
            localField: 'track_id',
            foreignField: '_id',
            as: 'track'
        }
    },
    {
        $lookup: {
            from: 'users',
            localField: 'author_id',
            foreignField: '_id',
            as: 'author'
        }
    }

])

--## Оператор агрегации `$unwind`-чтобы получить скаляр и избавится от избыточности

-- технический оператор
-- позволяет “развернуть” массив (отказаться от массива)

Пример
db.reactions.aggregate([
    { // получить данные трека
        $lookup: {
            from: 'tracks',
            localField: 'track_id',
            foreignField: '_id',
            as: 'track'
        }
    },
    { $unwind: '$track' },
    { // получить данные автора реакции
        $lookup: {
            from: 'users',
            localField: 'author_id',
            foreignField: '_id',
            as: 'author'
        }
    },
    { $unwind: '$author' },
    {
        $project: {
            'track_title': '$track.title',
            'author_fullname': '$author.fullname'
        }
    }
])

--Задача. Вывести данные о реакциях

проекция: имя_автора_реакции, название_трека, значение_реакции

db.reactions.aggregate([
    {
        $lookup: {
            from: 'tracks',
            localField: 'track_id',
            foreignField: '_id',
            as: 'track'
        }
    },
    {
        $unwind: '$track'
    },
    {
        $lookup: {
            from: 'users',
            localField: 'author_id',
            foreignField: '_id',
            as: 'author'
        }
    },
    {
        $unwind: '$author'
    },
    {
        $project: {
            'track_title': '$track.title',
            'author_fullname': '$author.fullname',
            'value': 1
        }
    },

])

--**Задача. Вывести данные о реакциях**

--проекция: `имя_автора_реакции`, `название_трека`, `имя_автора_трека`, `значение_реакции`



db.reactions.aggregate([
    { // получить данные трека
        $lookup: {
            from: 'tracks',
            localField: 'track_id',
            foreignField: '_id',
            as: 'track'
        }
    },
    { $unwind: '$track' },
    { // получить данные автора реакции
        $lookup: {
            from: 'users',
            localField: 'author_id',
            foreignField: '_id',
            as: 'author'
        }
    },
    { $unwind: '$author' },
    { // получить данные автора трека
        $lookup: {
            from: 'users',
            localField: 'track.author_id',
            foreignField: '_id',
            as: 'track_author'
        }
    },
    { $unwind: '$track_author' },
    {
        $project: {
            'track_title': '$track.title',
            'track_author_fullname': '$track_author.fullname',
            'author_fullname': '$author.fullname',
            'value': 1
        }
    }
])


--Задача. Вывести данные о треках
--проекция: название_трека, продолжительность_трека, имя_автора_трека, страна_автора_трека



db.tracks.aggregate([
    {
        $lookup: {
            from: 'users',
            localField: 'author_id',
            foreignField: '_id',
            as: 'author'
        }
    },
    {
        $unwind: '$author'
    },
    {
        $project: {
            'title': 1,
            'duration': 1,
            'author_fullname': '$author.fullname',
            'country': '$author.country'
        }
    }

])

--Задача. Вывести данные об одной произвольной реакции

--проекция: `значение_реакции`, `название_трека`

db.tracks.aggregate([
    {
         {
        $sample: {
            size: 1
        }
    },
        $lookup: {
            from: 'reactions',
            localField: '_id',
            foreignField: 'track_id',
            as: 'reactions'
        }
    },
    {
        $unwind: '$reactions'
    },
    {
        $project: {
            'title': 1,
            'reactions_value': '$reactions.value'
        }
    },
   
 
 
])

--$lookup: Этот этап выполняет операцию объединения (join) между коллекциями tracks и reactions. Он ищет документы в коллекции reactions, где поле track_id соответствует _id в коллекции tracks, и добавляет результаты в поле reactions нового массива в документах tracks.

$unwind: Этот этап "разворачивает" массив reactions, созданный на предыдущем этапе, превращая каждый элемент массива в отдельный документ. Это позволяет дальше работать с отдельными реакциями.

$project: Этот этап выбирает только определенные поля для вывода в результирующем документе. В данном случае он выбирает поле title из коллекции tracks и поле value из каждой реакции.

$sample: Этот этап случайным образом выбирает один документ из результата предыдущих этапов. Размер выборки задан как 1, поэтому будет выбран только один случайный документ.

Таким образом, этот код выбирает случайную реакцию к одному из треков и выводит название этого трека и значение реакции.


--Задача. Вывести данные о реакциях юзеров не из `USA`
--проекция: имя_автора_реакции, страна_автора_реакции, значение_реакции

db.reactions.aggregate([
    {
        $lookup: {
            from: 'users',
            localField: 'author_id',
            foreignField: '_id',
            as: 'author'
        }
    },
    { $unwind: '$author' },
    { $match: { 'author.country': { $ne: 'USA' } } },
    {
        $project: {
            '_id': 0,
            'author_fullname': '$author.fullname',
            'author_country': '$author.country',
            'value': 1
        }
    }
])

//$match: Этот этап фильтрует документы из коллекции users, исключая те, у которых значение поля country равно 'USA'.

$lookup: Этот этап выполняет операцию объединения (join) между коллекциями users и reactions. Он ищет документы в коллекции reactions, где поле author_id соответствует _id в коллекции users, и добавляет результаты в поле reactions нового массива в документах users.

$unwind: Этот этап "разворачивает" массив reactions, созданный на предыдущем этапе, превращая каждый элемент массива в отдельный документ. Это позволяет дальше работать с отдельными реакциями.

$project: Этот этап выбирает только определенные поля для вывода в результирующем документе. В данном случае он выбирает поля fullname и country из коллекции users, а также поле value из каждой реакции.

//--------------------------------------------------------------
Группировка / оператор $group
получает на входе документы
объединяет их в группы по заданному полю (или полям) группировки
на выходе - один документ равен одному уникальному значению поля группировки
Базовые операторы группировки (аккумуляторы)
$sum
$avg
$min
$max
$count
Пример. Вывести количественное распределение клиентов по странам
db.users.aggregate([
    {
        $group: {
            _id: '$country',
            total: { $count: {} }
        }
    }
])
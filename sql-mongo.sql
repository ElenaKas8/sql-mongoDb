--https://western-appeal-39b.notion.site/GenTech-12-Mar-6-2024-cbfede59ef8d4165ba98ef1fc3604387

--## Категории запросов

1. `CRUD` - более простые запросы
2. Aggregation - получение вычисленных данных

## MongoDB: CRUD

**Create**

- `insertOne()` добавить один документ
    - один аргумент
        - ассоц/массив (объект)
- `insertMany()` добавить несколько документов
    - один аргумент
        - массив ассоц/массивов (документов)

**Read**

- `findOne()`  найти (выбрать) один документ
- `find()` найти (выбрать) несколько документов
    - аргументы
        - `filter`
        - `projection`
- `countDocuments()` ко-во совпадений
    - аргументы
        - `filter`

**Update**

- `updateOne()` изменить один документ
- `updateMany()` изменить несколько документов
- `updateMany()` изменить несколько документов
    - аргументы
        - `filter`
        - `action`

**Delete**

- `deleteOne()` удалить один документ
- `deleteMany()` удалить несколько документов
    - аргументы

    --вывести страны всех юзеров
    db.users.find({}, {country: 1})


    --Задача. Вывести имена юзеров из Germanydb.users.find({country: "Germany"}, {fullname: 1, _id: '65e84764dee19d3874f5e0e9'
    
    --Задача. Вывести страну юзера с id ObjectId("65e8471eb0cf085e5c4f5442")
    db.user.findOne({_id: ObjectId("65e8471eb0cf085e5c4f5442")}, {country: 1})


    --Задача. Добавить два трека (tracks)
title
duration_secs
db.tracks.insertMany([{"title": "Track 1", "duration_secs": 120}, {"title": "Track 2", "duration_secs": 240}]) //tracks
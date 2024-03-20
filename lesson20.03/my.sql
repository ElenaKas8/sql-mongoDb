--https://western-appeal-39b.notion.site/GenTech-190923-m-be-m-fe-m-qa-ed7e7a76535646e0a5fe8daf9f27c866

Задача. Вывести названия треков продолжительностью от 1 мин до 1 часа (вкл.)
db.tracks.find(
    { duration_secs: { $gte: 1 * 60, $lte: 60 * 60 } },
    { title: 1, _id: 0 }
)
​
Примеры запросов
// Вывести всех юзеров
db.users.find()

// Вывести юзеров из USA
db.users.find(
    { country: 'USA' } // filter
)

// Вывести имена юзеров из USA
db.users.find(
    { country: 'USA' },
    { fullname: 1, _id: 0 }
)

// Вывести страну юзера 1
db.users.findOne(
    { _id: 1 },
    { country: 1, _id: 0 }
)

// Вывести треки продолжительностью от 5 мин
db.tracks.find(
    { duration_secs: { $gte: 5 * 60 } }
)


--https://western-appeal-39b.notion.site/GenTech-190923-m-be-m-fe-m-qa-ed7e7a76535646e0a5fe8daf9f27c866

Программа Studio3T
GUI программа-клиент для MongoDB
//Задача. Разблокировать юзеров не из China и не из UK,  увеличив им баланс на 10%


db.users.updateMany(
    {
        country: { $nin: ['China', 'UK'] },
        balance: { $gt: 0 }
    }, // filter
    {
        $unset: { is_blocked: null },
        $mul: { balance: 1.1 }
    } // action
)

//Задача. Вывести имена и балансы юзеров, у которых неотрицательный баланс

db.users.find(
    { balance: { $gte: 0 } },
    { fullname: 1, balance: 1, _id: 0 }
)


--Работа со списком в MongoDB
--Базовые операторы
--$push добавить значение в массив
--$pull удалить значение из массива (или множества)
--$pullAll удалить несколько значений из массива (или множества)
--$addToSet добавить значение в множество
--$each добавить список значений в массив или множество
--Пример. Добавить тег super всем трекам
db.tracks.updateMany(
    {}, // filter
    {
        $push: {
            tags: 'super'
        }
    }
)

Пример. Добавить несколько тегов к трекам
db.tracks.updateMany(
    {}, // filter
    {
        $addToSet: { tags: { $each: ['test1', 'test2'] } }
    }
)


Пример. Удалить несколько тегов
db.tracks.updateMany(
    {}, // filter
    {
        $pullAll: { tags: ['test1', 'test2'] }
    }
)

Пример. Поиск документов по тегу
db.tracks.find(
    { tags: 'supertest' }
)

// одно значение из списка
db.tracks.find(
    { tags: { $in: ['hello', 'test1'] } }
)

// все значения из списка
db.tracks.find(
    { tags: { $all: ['andrei', 'test1'] } }
)
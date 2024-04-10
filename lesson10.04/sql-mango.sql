--https://western-appeal-39b.notion.site/GenTech-190923-m-be-m-fe-m-qa-ed7e7a76535646e0a5fe8daf9f27c866

--Задача. Вывести имя одного произвольного юзера среди незаблокированных
--https://western-appeal-39b.notion.site/GenTech-16-Apr-10-2024-697590a660c24637994fa1f21f963544
db.users.aggregate([
    {
        $match: {
            blocked: {$ne: true}
        }
    },
    {
        $sample: {
            size: 1
        }
    },
    {
        $project: {
            _id: 0,
            fullname: 1
        }
    }
])
 

 --Задача. Вывести данные юзера с самым максимальным балансом

проекция: имя

db.users.aggregate([
    {
        $sort: {
            balance: -1
        }
    },
    {
        $limit: 1
    },
    {
        $project: {
            _id: 0,
            fullname: 1
        }
    }
])

--Задача. Используя метод countDocuments(), вывести ко-во заблокированных юзеров с балансом от 500 до 600 EUR

db.users.countDocuments({
    blocked: true,
    balance: {
        $gt: 500,
        $lt: 600
    }
})

db.users.aggregate([
    {
        $match: {
            blocked: true,
            balance: {
                $gt: 500,
                $lt: 600
            }
        }
    },
    {
        $count: 'total'
    }
])

--Задача. Вывести общее ко-во всех реакций

db.reactions.countDocuments({


})
​

Оператор $lookup / объединение коллекций
позволяет получить документы из другой коллекций
Пример. Вывести оценки (реакции), включая данные об их авторах
db.reactions.aggregate([
    {
        $lookup: {
            from: 'users', // название коллекции
            localField: 'author_id', // внеш/ключ в тек/коллекции
            foreignField: '_id', // перв/ключ в связанной коллекции
            as: 'author' // куда поместить данные
        }
    }
])

Задача. Вывести оценки (реакции), включая данные о треке

db.reactions.aggregate([
    {
        $lookup: {
            from: 'tracks',
            localField: 'track_id', 
            foreignField: '_id', 
            as: 'track' 
        }
    }
])
    
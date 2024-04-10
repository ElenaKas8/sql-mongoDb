//https://western-appeal-39b.notion.site/GenTech-190923-m-be-m-fe-m-qa-ed7e7a76535646e0a5fe8daf9f27c866

//https://western-appeal-39b.notion.site/GenTech-15-Mar-27-2024-8407779d07074c4c9b97f7dce63165d1
//Агрегация 

// # Агрегация в MongoDB

// **Основные методы**

// - `countDocuments()`
// - `aggregate()`

// ## Подсчет ко-ва документов / метод `countDocuments()`

// - один аргумент
//     - `фильтр`
// - возвращает `целое число` - ко-во совпадений

//Пример. Вывести ко-во клиентов из France
db.users.countDocuments({
    country: 'France'
})

//Задача. Вывести ко-во незаблокированных юзеров не из USA с балансом более 10EUR
db.users.countDocuments({
    blocked:{$ne:true},
    country: { $ne: 'USA' }, 
    balance: {
        $gt: 10
    }
})

//Задача. Вывести ко-во заблокированных юзеров не из China
db.users.countDocuments({
    blocked:true,
    country: { $ne: 'China' }
})

//Задача. Вывести ко-во треков с продолжительностью до 30 мин (вкл.)
db.tracks.countDocuments({
    duration: {
        $lte: 30*60
    }
})


//- `$match` фильтрация
- `$sort` сортировка
- `-1` по убыванию
- `1` по возрастанию
- `$project` проекция
- `$count` возврат ко-ва совпадений
- `$limit` лимитирование
- `$skip` пропустить (документы)
- `$group` группировка
- `$lookup` объединение коллекций
- `$addFields` добавить поля
- `$sample` получить произвольные документы

## Метод `aggregate()`

- аргументы
- (1) массив этапов обработки (`pipeline`, конвейер)


Пример конструкции (синтаксис)
db.collection.aggregate([
	{}, // этап 1
	{}, // этап 2
	{}, // этап 3
	{}, // этап 4
	{} // этап 5
])
​
Пример. Вывести всех юзеров
db.users.aggregate()
​
Пример. Работа с юзерами

// вывести юзеров с балансом от 10 (EUR)
db.users.aggregate([
    { // фильтрация
        $match: {
            balance: { $gte: 10 }
        }
    }
])


// вывести незаблокир. юзеров
db.users.aggregate([
    {
        $match: {
            blocked: { $ne: true }
        }
    }
])

// вывести всех юзеров по убыванию баланса
db.users.aggregate([
    {
        $sort: {
            balance: -1
        }
    }
])


// вывести ТОП-1 юзеров по макс. балансу
db.users.aggregate([
    { // этап 1-принимает коллекцию пользователей
        // этап 2-возвращает отсортированный массив
        $sort: { balance: -1 }
    },
    
    { // принимае И ВОЗВРАЩАЕТ ТОП-1
        $limit: 1
    }
])

//Задача. Вывести одного незаблокированного юзера с минимальным балансом

db.users.aggregate([
    { $match: { is_blocked: { $ne: true } } }, // фильтрация
    { $sort: { balance: 1 } }, // сортировка (по возраст.)
    { $limit: 1 } // лимитирование
])
    
//Пример. Вывести имена всех юзеров

db.users.aggregate([
    {
        $project: {
            fullname: 1,
            _id: 0
        }
    }
])

//
//Задача. Вывести названия трех самых продолжительных треков

db.tracks.aggregate([
    { $sort: { duration_secs: -1 } }, // сортировка
    { $limit: 3 }, // лимитирование
    { $project: { title: 1, _id: 0 } } // проекция
])

//Задача. Вывести имена юзеров с балансом от 10 до 1000 EUR (включительно) в порядке убывания баланса

db.users.aggregate([
    { $match: { balance: { $gte: 10, $lte: 1000 } } },// фильтрация
    { $sort: { balance: -1 } },// сортировка
    { $project: { fullname: 1, _id: 0 } }// проекция

])


//$skip
//Пример. Вывести одного юзера, который находится на втором месте по макс. балансу
db.users.aggregate([
    { $sort: { balance: -1 } },
    { $skip: 1 },
    { $limit: 1 }
])

//$countDocuments

//Пример. Вывести ко-во незаблокированных юзеров
// вар. 1
db.users.countDocuments(
    { is_blocked: { $ne: true } } // filter
)

// вар. 2
db.users.aggregate([
    { $match: { is_blocked: { $ne: true } } },
    { $count: 'unblocked_users' }
])

//Задача. Вывести ко-во треков с продолжительностью до 100 мин (вкл.)
db.users.aggregate([
    { $match: { duration: { $lte: 100*60 } } },
    { $count: 'total' }
])

//$sample-вывести случайные документы

//Пример. Вывести один произвольный трек**


db.tracks.aggregate([
    {
        $sample: { size: 1 }
    }
])

//Задача. Вывести названия трех произвольных треков
db.tracks.aggregate([
    {
        $sample: { size: 3 }
    },
    { $project: { title: 1, _id: 0 } }
])


//Задача. Вывести ко-во юзеров не из France с балансом от 100 до 500 EUR (вкл.)

db.users.aggregate([
    { $match: { country: { $ne: 'France' }, balance: { $gte: 100, $lte: 500 } } 
},
])
https://western-appeal-39b.notion.site/GenTech-190923-m-be-m-fe-m-qa-ed7e7a76535646e0a5fe8daf9f27c866 

https://western-appeal-39b.notion.site/GenTech-Summary-Mar-25-2024-22cd1afeb9094cc6a7b694bc544f06b7


# GenTech: Summary / Mar 25, 2024

## Query API

- язык запросов `MongoDB`

## Сетевой порт

- идентификатор сетевой программы

## Запрос на авторизацию

- `READ` (по `CRUD`)

## Отличие `$pull` от `$pullAll`

- `$pull` - удалить значение из массива (или множества)
- `$pullAll` - удалить несколько значений из массива (или множества)

## Отличие `$addToSet` от `$push`

- `$push` добавить значение в **массив**
- `$addToSet` добавить значение в **множество**

**Задача. Вывести названия статей, которые принадлежат автору с id `ObjectId("65e8471eb0cf085e5c4f5443")` 
и имеют тег `test4`**

db.articles.find(
    { author_id: ObjectId("65e8471eb0cf085e5c4f5443"), tags: "test4" },
    { title: 1, _id: 0 }
)

--вывести ттатьи у которых есть теги alpha,beta(оба тега сразу)

db.articles.find(
    { tags: { $all: ["alpha", "beta"] } },
    { title: 1, _id: 0 }
)

--вывести все треки с продолжительностью до 1 млм сек включительно

db.tracks.find(
    { duration_secs: { $lte: 60 } },
    { title: 1, duration_secs: 1, _id: 0 }
)
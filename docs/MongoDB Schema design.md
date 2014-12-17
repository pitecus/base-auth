# MongoDB Schema design


### Terminology

RDBMS       | MongoDB
------------|---
Database    | Database
Table       | Collection
Row         | Document
Index       | Index
Join        | Embedded Document
Foreign Key | Reference

Relational Schema Design focuses on data storage.

Document Schema Design focuses on data use.

## Referencing vs. Embedding

Embedding is a bit like pre-joining data. Document level operations are easy for the server to handle. Embed when the "many" objects always appear with (viewed in the context of) their parents. Reference when you need more flexibility.

Schema design considerations.

Priorities:

* High consistency
* High read performance
* High write performance

Measurements:

* Read/Write Ratio
* Types of Queries/Updates
* Data life-cycle and growth
* Analytics (map reduce, aggregation)

Pipeline operators:

* $project
* $match
* $limit
* $skip
* $sort
* $group
* $unwind

## Data Manipulation

### Conditional Query Operators:

Scalar:

* $ne
* $mod
* $exists
* $type
* $ly
* $lte
* $ge
* $gt
* $gte
* $ne

Vector:

* $in
* $nin
* $all
* $size

### Atomic Update Operators:

Scalar:

* $inc
* $set
* $unset

Vector:

* $push
* $pop
* $pull
* $pushAll
* $pullAll
* $addToSet

## Where do you put the reference?

Reference go single publisher on books:

* Use when items have **unbounded growth** (unlimited #of books)

Array of books in publisher document

* Optimal when **many** means a **handful** of items
* Use when there is a **bound** on potential **growth**
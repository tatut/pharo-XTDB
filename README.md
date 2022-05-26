# pharo-XTDB

![test workflow](https://github.com/tatut/pharo-XTDB/actions/workflows/test.yml/badge.svg)

XTDB client for Pharo Smalltalk

Uses the XTDB HTTP API.

## Quick start

The client works by mapping Smalltalk classes to XTDB documents.

Defining the mapping:
```smalltalk
Object subclass: #Person
   instanceVariableNames: '_xtId lastName firstName address email company'
   classVariableNames: ''
   package: 'XTDB-Examples'!

"accessor methods omitted"

xtMapping
  ^ XtEntityMapping withAll: {
    "the document id in XTDB"
    #':xt/id' -> #_xtId .

    "map XTDB attributes to regular fields"
    #':last-name' -> #lastName .
    #':first-name' -> #firstName .
    #':email' -> #email .

    "Define :address attribute to be a link to an Address document.
    Child is owned, so that when the parent is stored, the child
    is also stored automatically."
    XtChildMapping of: #':address' -> #address to: Address .

    "Define link to company. Link is not owned, so it is not
    stored automatically when the linking entity is stored."
    XtLinkMapping of: #':company' -> #company to: Company .

  }
```

After adding the mapping, you can create a client and store instances:
```smalltalk

"Create a client and point it to XTDB HTTP API (https://docs.xtdb.com/clients/http/)"
xt := XtClient new url: 'http://xtdb-server-host/_xtdb/'.


"Store a new person along with its address.
Id fields are not required, UUID ids are automatically generated
for any documents that don't have an id.

If id is present, the store operation will write a new version
of the document.
"
xt store: (Person new
  firstName: 'Max';
  lastName: 'Power';
  email: 'max@example.com';
  address: (Address new
              streetAddress: 'Smalltalk street 1';
              postalCode: '12345';
              country: 'FI';
              yourself);
  yourself).


"Query with regular Smalltalk predicates. The operations will
generate a datalog query. All the mapped fields will be pulled
from the database by default.
You can use regular comparison operators like (=, <, <=, >, >=)
and #textSearch: to do a Lucene query (requires that XTDB has
Lucene indexing module enabled).
"
xt q: Person matching: [ :p |
  (p firstName = 'Max') | (p address streetAddress textSearch: 'small*') ].
"returns an OrderedCollection containing Person instances"


"Delete (history is still retained) by calling delete. It will delete all the owned
children of the entity recursively.
"
p := (xt q: Person matching: [ :p | p firstName = 'Max' ]) results first.
xt delete: p.
```

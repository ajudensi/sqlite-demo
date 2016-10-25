# sqlite-demo

A progressive collection of sql commands to create specific sqlite database queries to primarily to demonstrate the concept of foreign keys and table relatioship.

**The idea**

Mirrowing the logic of blogs/cms that enable user priviledges. Example, a blog can have 4 type of users.
Here, I chose

- 1. Admin
- 2. Editor
- 3. Writer
- 4. Reader (Who could as well just be a subscriber)

**So, we have created two tables**
- 1. members
- 2. priviledges

Relationship between the two tables is needed for members to have a priviledge. Thus, I've used the member_priviledge as the id (auto incrementing) of the priviledges tables as a foreign key in the members table. In other words, every member will have a link to priviledge (admin, editor, writer, reader).

**Requirement**
- 1. Database = sqlite3
- 2. Language = sql

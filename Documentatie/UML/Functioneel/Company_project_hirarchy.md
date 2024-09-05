```puml

rectangle Organization as org
rectangle Company as comp
rectangle User as usr
rectangle Project as prj
rectangle Board as brd
rectangle Task as tsk
rectangle "Task list" as tsk_lst
org -- comp :< customer of
comp -- prj :< project for
prj--brd :< board for
brd--tsk_lst :< list on
tsk_lst--tsk :< task on

comp -- usr :< works at
org -- usr :< works at

```

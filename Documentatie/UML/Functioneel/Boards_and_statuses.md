```puml
title Boards and statuses
skinparam nodesep 10
skinparam ranksep 10
left to right direction
skinparam groupInheritance 3

(backlog) #orange
(in progress) as in_progress  #orange
(in review) as in_review #orange 
(development) #99FF00
(staging) #99FF00
(live) #green
(wishlist) #Tomato
(aanvragen) #Tomato
actor "Externe beheerder" as EK

note "Input nodig van klant" as customernotifynote 
note "input nodig van Bluenotion" as bluenote 

customernotifynote .[norank]. wishlist
customernotifynote .[norank]. staging
customernotifynote .[norank]. aanvragen
bluenote .[norank]. aanvragen
bluenote .[norank]. wishlist

aanvragen -DOWN-> backlog : ✓
wishlist -[norank]-> backlog : ✓
backlog -DOWN-> in_progress : ✓
in_progress -DOWN-> in_review : ✓
in_review -DOWN-> development : ✓
development -DOWN-> staging : ✓
staging -DOWN-> live : ✓
in_review -[norank]-> backlog : Denied by reviewer
wishlist -[norank]-> wishlist : Denied by PM,TL of klant
aanvragen -[norank]-> aanvragen : Denied by PM/TL
development -[norank]-> backlog : Denied by customer
staging -[norank]-> backlog : Denied by customer
in_progress -[norank]-> wishlist : Functionality is nice to have but outside of scope
EK --> aanvragen : Voorgestelde situatie
' EK ..[norank]..> backlog : Oude situatie


legend left
    | Color | Status |
    | <#Tomato> | Not started |
    |<#Orange>| Open |
    |<#99FF00>| Done |
    |<#Green>| Closed |
    | ✓ | Accepted |
endlegend

```

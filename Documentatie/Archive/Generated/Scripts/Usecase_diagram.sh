#!/bin/bash

#Input
CSV_FILE="../Source/requirementstablecsv.csv"

#Output
OUTPUT_FILE="usecase_diagram.md"

#Should be locals
CURRENT_MAIN_REQUIREMENT_ID=""
ACTOR_ID=""

#Legend colors
DEFINE_NAME="Define"
DEFINE_COLOR="#999999"
UX_NAME="UX"
UX_COLOR="#AA55AA"
UI_NAME="UI"
UI_COLOR="#AA00AA"
FE_NAME="FE"
FE_COLOR="#349034"
BE_NAME="BE"
BE_COLOR="#02CB02"
TESTING_NAME="Testing"
TESTING_COLOR="#00FF00"
DENIED_NAME="Rejected"
DENIED_COLOR="#FF0000"
STATUS_FINISHED="[x]"
STATUS_UNFINISHED="[ ]"
MUST_COLOR="#FF9999"
SHOULD_COLOR="#DD9999"
COULD_COLOR="#BB9999"
WONT_COLOR="#999999"

# Function to print the header for the PlantUML file
print_puml_header() {
  echo '```plantuml' > $OUTPUT_FILE
  echo "left to right direction" >> $OUTPUT_FILE
  echo "skinparam packageStyle rect" >> $OUTPUT_FILE
}

# Function to print the footer for the PlantUML file
print_puml_footer() {
  echo '```' >> $OUTPUT_FILE
}

print_puml_actor_hirarchy(){
  echo ':ACT1 Externe klant Admin: as ACT1
:ACT2 Bluenotion Admin: as ACT2
:ACT3 Bluenotion medewerker: as ACT3
:ACT4 notification manager: as ACT4
:ACT5 Externe klant Medewerker: as ACT5
ACT2-LEFT-|>ACT3
ACT2-LEFT-|>ACT1
ACT1-LEFT-|>ACT5
ACT3-LEFT-|>ACT5'>>$OUTPUT_FILE
}

print_puml_legend(){
  echo "legend left
   | **Done** | **Planned** | **Milestone** |
   | <color:$DEFINE_COLOR><size:20>●</size></color> | <color:$DEFINE_COLOR><size:20>○</size></color>| $DEFINE_NAME |
   | <color:$UX_COLOR><size:20>●</size></color> | <color:$UX_COLOR><size:20>○</size></color>| $UX_NAME |
   | <color:$FE_COLOR><size:20>●</size></color> | <color:$FE_COLOR><size:20>○</size></color>| $FE_NAME |
   | <color:$BE_COLOR><size:20>●</size></color> | <color:$BE_COLOR><size:20>○</size></color>| $BE_NAME |
   | <color:$TESTING_COLOR><size:20>●</size></color> | <color:$TESTING_COLOR><size:20>○</size></color>| $TESTING_NAME |
   | <color:$DENIED_COLOR><size:20>●</size></color> | <color:$DENIED_COLOR><size:20>○</size></color>| $DENIED_NAME |

  | **Task color** | **Priority** |
  | <$MUST_COLOR> | Must have |
  | <$SHOULD_COLOR> | Should have |
  | <$COULD_COLOR> | Could have |
  | <$WONT_COLOR> | Won't have |
  end legend">>$OUTPUT_FILE
}

MAIN_REQUIREMENT_BUILDER=""
MAIN_REQUIREMENT_CLOSER=""
REQUIREMENT_BUILDER=""
RELATION_BUILDER=""
MILESTONES_BUILDER=""


OUTPUT_UC_BUFFER=""
RELATION_BUFFER=""
CURRENT_MAIN_ID=""
CURRENT_MAIN_DESCRIPTION=""
CURRENT_SUB_ID=""
CURRENT_SUB_DESCRIPTION=""

CURRENT_SUB_PRIORITY=""

add_priority_color(){
    if [[ $CURRENT_SUB_PRIORITY == *"Must"* ]]; then
      OUTPUT_UC_BUFFER="$OUTPUT_UC_BUFFER $MUST_COLOR"
    fi
    if [[ $CURRENT_SUB_PRIORITY == *"Should"* ]]; then
      OUTPUT_UC_BUFFER="$OUTPUT_UC_BUFFER $SHOULD_COLOR"
    fi
    if [[ $CURRENT_SUB_PRIORITY == *"Could"* ]]; then
      OUTPUT_UC_BUFFER="$OUTPUT_UC_BUFFER $COULD_COLOR"
    fi
    if [[ $CURRENT_SUB_PRIORITY == *"Won't"* ]]; then
      OUTPUT_UC_BUFFER="$OUTPUT_UC_BUFFER $WONT_COLOR"
    fi

}

add_main_to_out(){
  OUTPUT_UC_BUFFER="$OUTPUT_UC_BUFFER 
usecase \"$CURRENT_MAIN_DESCRIPTION\" as $CURRENT_MAIN_ID"
# add_priority_color
}

add_sub_to_out(){
  OUTPUT_UC_BUFFER="$OUTPUT_UC_BUFFER 
usecase \"$CURRENT_SUB_DESCRIPTION\" as $CURRENT_SUB_ID"
add_priority_color
}

add_status(){
      STATUS_BUILDER=""
      if [[ $status == *$DEFINE_NAME* ]]; then
          CURRENT_SUB_DESCRIPTION="$CURRENT_SUB_DESCRIPTION <color:$DEFINE_COLOR>"
          add_status_symbol
      fi
      if [[ $status == *$UX_NAME* ]]; then
          CURRENT_SUB_DESCRIPTION="$CURRENT_SUB_DESCRIPTION <color:$UX_COLOR>"
          add_status_symbol
      fi
      if [[ $status == *$UI_NAME* ]]; then
          CURRENT_SUB_DESCRIPTION="$CURRENT_SUB_DESCRIPTION <color:$UI_COLOR>"
          add_status_symbol
      fi
      if [[ $status == *$FE_NAME* ]]; then
          CURRENT_SUB_DESCRIPTION="$CURRENT_SUB_DESCRIPTION <color:$FE_COLOR>"
          add_status_symbol
      fi
      if [[ $status == *$BE_NAME* ]]; then
          CURRENT_SUB_DESCRIPTION="$CURRENT_SUB_DESCRIPTION <color:$BE_COLOR>"
          add_status_symbol
      fi
      if [[ $status == *$TESTING_NAME* ]]; then
          CURRENT_SUB_DESCRIPTION="$CURRENT_SUB_DESCRIPTION <color:$TESTING_COLOR>"
          add_status_symbol
      fi
      if [[ $status == *$DENIED_NAME* ]]; then
          CURRENT_SUB_DESCRIPTION="$CURRENT_SUB_DESCRIPTION <color:$DENIED_COLOR>"
          add_status_symbol
      fi
}

add_status_symbol(){
      if [[ $status == *$STATUS_FINISHED* ]]; then
        CURRENT_SUB_DESCRIPTION="$CURRENT_SUB_DESCRIPTION <size:20>●</size></color>"
      elif [[ $status == *$STATUS_UNFINISHED* ]]; then
        CURRENT_SUB_DESCRIPTION="$CURRENT_SUB_DESCRIPTION <size:20>○</size></color>"
      fi
}

generate_usecase_diagram() {
  print_puml_header
  print_puml_actor_hirarchy
  while IFS=";" read -r ref_no main_req sub_req priority primary_actor doc_references status; do
  generate_markdowntable_fromcsv
    # Replace . with _
    refno_with_underscore=$(echo -n $ref_no | tr . _)    
    # Check if it is a main requirement
    if [[ -n "$main_req" ]]; then
      #Close the previous main requirement
      if [[ -n "$CURRENT_MAIN_ID" ]]; then
        add_main_to_out
      fi

      CURRENT_MAIN_ID=$refno_with_underscore
      CURRENT_MAIN_DESCRIPTION="$ref_no: $main_req"

      ACTOR_ID=$(echo $primary_actor | grep -o '.*ACT.')
      RELATION_BUFFER="$RELATION_BUFFER 
      $ACTOR_ID -DOWN-> $refno_with_underscore"

    fi
    
    # Check if it is a sub-requirement
    if [[ -n "$sub_req" ]]; then
      #Close the previous sub-requirement
      if [[ -n "$CURRENT_SUB_ID" ]]; then
        add_sub_to_out
      fi

      CURRENT_SUB_ID=$refno_with_underscore
      CURRENT_SUB_DESCRIPTION="$ref_no: $sub_req \\n"
      CURRENT_SUB_PRIORITY="$priority"
      RELATION_BUFFER="$RELATION_BUFFER
      $CURRENT_MAIN_ID -DOWN->  $refno_with_underscore
      "
    fi

    if [[ -n "$status" ]]; then
      add_status
    fi

  done < <(tail -n +2 $CSV_FILE) # Skip the header line
  
  add_main_to_out
  add_sub_to_out

  echo "$OUTPUT_UC_BUFFER" >> $OUTPUT_FILE
  echo "$RELATION_BUFFER" >> $OUTPUT_FILE
  print_puml_legend
  print_puml_footer
  # MD_TABLE_BUFFER=$(echo -n $MD_TABLE_BUFFER | grep -o '\n(?= *\|*)*\[' )  
  echo "$MD_TABLE_BUFFER" >> $OUTPUT_FILE
}

MD_TABLE_BUFFER=""
MD_TABLE_ROW_BUFFER=""

add_table_headers(){
  MD_TABLE_BUFFER="$MD_TABLE_BUFFER 
| Ref no | Main requirement | Sub requirement | Prioriteit (MoSCoW) | Document references | Status |
|---|---|---|---|---|---|
"
}

generate_markdowntable_fromcsv(){
    status_no_newlines="${status//$'[\r\n]'/}"
    if [[ -n "$main_req" || -n "$sub_req" ]]; then
    MD_TABLE_BUFFER="$MD_TABLE_BUFFER| $ref_no | $main_req | $sub_req | $priority | $doc_references | $status_no_newlines |
"
    elif [[ -n "$status" ]]; then
      MD_TABLE_BUFFER=${MD_TABLE_BUFFER%\|*}
      MD_TABLE_BUFFER="$MD_TABLE_BUFFER </br> $status_no_newlines |
"
    fi
}


# Run the function to generate the diagram
add_table_headers
generate_usecase_diagram

echo "PlantUML use case diagram generated in $OUTPUT_FILE"

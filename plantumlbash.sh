#!/bin/bash

# Input CSV file
CSV_FILE="requirementstablecsv.csv"

# Output PlantUML file
OUTPUT_FILE="usecase_diagram.puml"
CURRENT_MAIN_REQUIREMENT=""
ACTOR_ID=""
DEFINE_COLOR="#999999"
UX_COLOR="#AA55AA"
UI_COLOR="#AA00AA"
FE_COLOR="#349034"
BE_COLOR="#02CB02"
TESTING_COLOR="#00FF00"
DENIED_COLOR="#FF0000"

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
    | **Color** | **Milestone** |
    | <$DEFINE_COLOR> | Define |
    | <$UX_COLOR> | UX |
    | <$UI_COLOR> | UI |
    | <$FE_COLOR> | FE |
    | <$BE_COLOR> | BE |
    | <$TESTING_COLOR> | Testing |
    | <$DENIED_COLOR> | Denied |
  end legend">>$OUTPUT_FILE
}

print_puml_full_main_requirement(){
  
}

# Function to parse the CSV file and generate the PlantUML content
generate_usecase_diagram() {
  print_puml_header
  print_puml_actor_hirarchy

  while IFS=";" read -r ref_no main_req sub_req priority primary_actor doc_references status; do
    # Replace . with _
    refno_with_underscore=$(echo $ref_no | tr . _)    
    # Check if it is a main requirement
    if [[ -n "$main_req" ]]; then
      echo "  usecase \"$ref_no: $main_req\" as $refno_with_underscore" >> $OUTPUT_FILE
      CURRENT_MAIN_REQUIREMENT=$refno_with_underscore
      ACTOR_ID=$(echo $primary_actor | grep -o '.*ACT.')
      echo  "$ACTOR_ID -DOWN-> $refno_with_underscore" >> $OUTPUT_FILE
    fi
    
    # Check if it is a sub-requirement
    if [[ -n "$sub_req" ]]; then
      echo "  usecase \"$ref_no: $sub_req\" as $refno_with_underscore" >> $OUTPUT_FILE
      echo "  $CURRENT_MAIN_REQUIREMENT -DOWN->  $refno_with_underscore" >> $OUTPUT_FILE
    fi

    if [[ -n "$status" ]]; then
      echo "$status"
    fi

  done < <(tail -n +2 $CSV_FILE) # Skip the header line
  print_puml_legend
  print_puml_footer
}

# Run the function to generate the diagram
generate_usecase_diagram

echo "PlantUML use case diagram generated in $OUTPUT_FILE"

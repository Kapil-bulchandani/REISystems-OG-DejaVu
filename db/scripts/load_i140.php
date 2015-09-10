<?php

$servername = "localhost";
$username = "appuser";
$password = "password";
$dbname = "dejavu_application";
$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} 
$sql = "SELECT * FROM immi_i140 ";
$result = $conn->query($sql);

// mongo client
$m = new MongoClient();
// creating database, if its not exists it will create with the the name we are giving
$db = $m->dejavu_mongo;
// creating collection.
$collection = $db->froms;

if ($result->num_rows > 0) {
    $json_response = array();
    $row_array = array();
    while($row = $result->fetch_assoc()) {
        $form = getFormAttributes();
        $row_array['_id'] =  generateRandomNumber(15);
        $row_array['form'] =  $form['form'];
        $row_array['version']= $form['version'];
        $row_array['uscis'] = uscisAttributes();
        $row_array['applicant']  = applicantAttributes($row);
        $row_array['petitioner'] = petitionerAttributes();
        $row_array['relatives'][] = relativeAttributes();
        $row_array['relatives'][] = relativeAttributes();
        $row_array['relatives'][] = relativeAttributes();
        array_push($json_response,$row_array);
        try {
            $collection->insert($row_array);
        }
        catch(MongoException $e) {
            print_r($e);
        }
        // unsetting the relatives array
        unset($row_array['relatives']);
    }
}

// Functions to create random names, numbers, and attributes of the application

// generate form attributes which normally consists of form name and version
function getFormAttributes(){
	$row= array();
	$row['form'] = "i140";
	$row['version'] = "1615-0015";
	return $row;
}


// generates uscis Attributes
function uscisAttributes(){
	$row = array();
	$row['priority_date'] = generateRandomDate();
	$row['fee_paid'] = generateRandomNumber(4);
	$row['consulate'] = generateRandomString(5);
	$row['classification'] = generateRandomString(3);
	$row['certification'] = generateRandomString(5);
	$row['actions'] = generateRandomString(4);
	$row['remarks'] = generateRandomString(12);
	return $row;

}

// generate petitioner attributes.
function petitionerAttributes(){
	$row=array();
	$row['last_name']=generateRandomNames(2);
	$row['first_name']=generateRandomNames(1);
	$row['middle_name']=generateRandomString(1);
	$row['company_name']=generateRandomString(3)." Inc.";
	$row['irs_tax_number']=generateRandomNumber(7);
	$row['ssn']=generateRandomNumber(9);
	$row['mailing_address']['in_care_of_name'] = $row['first_name'];
	$row['mailing_address']['address'] = generateRandomString(5);
	$row['mailing_address']['address2'] = generateRandomString(5);
	$row['mailing_address']['address2_type'] = "apt";
	$row['mailing_address']['city'] = generateRandomString(3);
	$row['mailing_address']['state'] = strtoupper(generateRandomString(2));
	$row['mailing_address']['zip_code'] = generateRandomNumber(5);
	$row['mailing_address']['postal_code'] = "";
	$row['mailing_address']['province'] = "";
	$row['mailing_address']['country'] = strtoupper(generateRandomString(4));
	$row['petitioner_type']="company";
	$row['petitioner_type_other_explanation']="";
	$row['company']['type_of_business'] = generateRandomString(5);
	$row['company']['established_date'] = generateRandomDate();
	$row['company']['current_no_of_US_employees'] = generateRandomNumber(3);
	$row['company']['gross_annual_income'] = generateRandomNumber(7);
	$row['company']['net_annual_income'] = generateRandomNumber(7);
	$row['company']['NAICS_code'] = generateRandomNumber(5);
	$row['company']['DOL_ETA_case_number'] = generateRandomNumber(7);
	$row['company']['DOL_ETA_filing_date'] = generateRandomDate();
	$row['company']['labor_certification_expiration_date'] = generateRandomDate();
	$row['individual']['occupation'] = "";
	$row['individual']['annual_income'] = "";
    $row['signature'] = generateRandomString(5);
    $row['date_of_signature'] = generateRandomDate();
    $row['daytime_phone_number'] = "1".generateRandomNumber(9);
    $row['mobile_phone_number'] = "1".generateRandomNumber(9);
    $row['email_address'] = generateRandomString(10);
    $row['job_title'] = generateRandomString(5);
    return $row;
}

// application information
function applicantAttributes($rows){
	$row = array();
	$row['alien_number'] = $rows['a_number'];
	$row['first_name'] = $rows['first_name'];
	$row['middle_name'] = $rows['middle_name'];
	$row['last_name'] = $rows['last_name'];
	$row['date_of_birth'] = trim($rows['date_of_birth']);
	$row['address']['in_care_of_name'] = generateRandomNames(1);
	$row['address']['address'] = generateRandomString(5);
	$row['address']['address2'] = generateRandomString(5);
	$row['address']['address2_type'] = "apt";
	$row['address']['city'] = generateRandomString(3);
	$row['address']['state'] = strtoupper(generateRandomString(2));
	$row['address']['zip_code'] = generateRandomNumber(5);
	$row['address']['postal_code'] = generateRandomNumber(5);
	$row['address']['province'] = strtoupper(generateRandomString(4));
	$row['address']['country'] = strtoupper(generateRandomString(4));
    $row['email_address'] = generateRandomString(10);
    $row['daytime_phone_number'] = "1".generateRandomNumber(9);
    $row['date_of_birth'] = generateRandomDate();
    $row['city_of_birth'] = generateRandomString(7);
    $row['state_of_birth'] = strtoupper(generateRandomString(2));
    $row['country_of_birth'] = strtoupper(generateRandomString(4));
    $row['country_of_citizenship'] = strtoupper(generateRandomString(5));
    $row['country_of_natinoality'] = strtoupper(generateRandomString(4));
    //$row['alien_number'] = ""; 
    $row['ssn'] = generateRandomNumber(9);
    $row['date_of_arrival'] = generateRandomDate();
    $row['i94'] = generateRandomNumber(9);
    $row['passport_number'] = generateRandomNumber(8);
    $row['travel_document_number'] = generateRandomNumber(6);
    $row['country_of_issuance_of_passport_or_travel_document'] = strtoupper(generateRandomString(4));
    $row['expiration_date_of_passport_or_travel_document'] =generateRandomDate();
    $row['current_non_immigrant_status'] = generateRandomString(7);
    $row['non_immigrant_status_expiration_date']= generateRandomDate();
    return $row; 

}

// relatives
function relativeAttributes(){
	$row = array();
    $row['last_name']=generateRandomNames(2);
	$row['first_name']=generateRandomNames(1);
	$row['middle_name']=generateRandomString(1);
    $row['date_of_birth'] = generateRandomDate();
    $row['country_of_birth'] = strtoupper(generateRandomString(4));
    $row['relationship'] = generateRandomString(5);
    $row['applying_for_adjustment_of_status'] = "No";
    $row['applying_for_visa'] = "No";
    return $row;

}

// random string generation
function generateRandomString($length = 10) {
    $characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    $charactersLength = strlen($characters);
    $randomString = '';
    for ($i = 0; $i < $length; $i++) {
        $randomString .= $characters[rand(0, $charactersLength - 1)];
    }
    return $randomString;
}

// random number/integer generation
function generateRandomNumber($length = 10) {
    $characters = '0123456789';
    $charactersLength = strlen($characters);
    $randomNumber = '';
    for ($i = 0; $i < $length; $i++) {
        $randomNumber .= $characters[rand(0, $charactersLength - 1)];
    }
    return $randomNumber;
}
// random date generation
function generateRandomDate(){
	$int= mt_rand(1262055681,1262055681);
	$date = date("Y-m-d",$int);
	return $date;
}

// Random name generation
function generateRandomNames($name=1){
	$names = array('Christopher','Ryan','Ethan','John','Zoey','Sarah','Michelle','Samantha','Anita','Ullas','Joe','Mike','Pedda','Ayaskant','Viktor','Vikas','Malcom','Iams');
 	$surnames = array('Walker','Thompson','Anderson','Johnson','Tremblay','Peltier','Cunningham','Simpson','Mercado','Sellers','Kozak','Halici','Joseph','Sahu','Yadav','Gupta');
 	$random_name = $names[mt_rand(0, sizeof($names) - 1)];
 	$random_surname = $surnames[mt_rand(0, sizeof($surnames) - 1)];
 	if($name==1)
 		return $random_name;
 	else
 		return $random_surname;
}


?>
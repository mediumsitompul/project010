<?php
  $db = "db_province";
  $host = "192.168.100.100:6607";
  $db_user = 'pqr';
  $db_password = 'Pensi2021';
  $link = mysqli_connect($host, $db_user, $db_password, $db);
  if(isset($_REQUEST["pilihan0"])){
    $pilihan0 = $_REQUEST["pilihan0"];
  }else{
    $pilihan0 = "";
  }

  $json["datajs"] = array();
  $pilihan0 = mysqli_real_escape_string($link, $pilihan0);
  $sql = "SELECT * FROM t_province";
  $res = mysqli_query($link, $sql);
  $numrows = mysqli_num_rows($res);
  if($numrows > 0){
     //check if there is any data
      while($array = mysqli_fetch_assoc($res)){
          array_push($json["datajs"], $array);
      }
  }else{
      $json["error"] = true;
      $json["errmsg"] = "No any data to show.";
  }
  mysqli_close($link);
  header('Content-Type: application/json');
  echo json_encode($json);
?>

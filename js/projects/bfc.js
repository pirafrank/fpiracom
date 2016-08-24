function sumPasswsType() {
    // calculate all the possible value a char can have
    // by summing the values in html inputs

    var inputArray = document.getElementsByName('ptype');
    var total=0;
    for (var i=0; i<inputArray.length; i++){
        if (inputArray[i].checked) {
            if (parseInt(inputArray[i].value)) {
                //console.log(inputArray[i].value);
                total += parseInt(inputArray[i].value);
            }
        }
    }

    return total;
}

function printWithCommas(n) {
    return n.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
}

function calculate() {
    var possibleValues = sumPasswsType();
    var passwdLength = document.getElementById('getPL').value;
    var ms = document.getElementById('getMs').value;
    var totalTimeMs,hours,days,years;

    if (possibleValues == 0 || passwdLength == 0 || ms == 0) {
        window.alert("Oops: One or more field is empty. Please fill required data and check at least one box.");
        return;
    }

    totalTimeMs = Math.pow(possibleValues, passwdLength)*ms;
    if (totalTimeMs == NaN) {
        window.alert("Oops: Your input wasn't valid! Please insert integer values.")
        return;
    }

    hours = printWithCommas((totalTimeMs/3600000).toFixed(2));
    days = printWithCommas((totalTimeMs/3600000/24).toFixed(2));
    years = printWithCommas((totalTimeMs/3600000/24/365).toFixed(2));

    document.getElementById("results").innerHTML = "\
              <p>To crack your password it will take (at max):<br></p>\
              <p>\
                <u>"+hours+"</u> hours\
              </p>\
              <p>\
                <u>"+days+"</u> days\
              </p>\
              <p>\
                <u>"+years+"</u> years\
              </p>\
    ";
}

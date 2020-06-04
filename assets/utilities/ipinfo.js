function ipinfo() {
  var ipaddr = document.getElementById("ipaddr").value;
  document.getElementById("ipaddr").value = "";
  window.open(
    "https://ipinfo.io/" + ipaddr + "/json",
    "_blank",
    "noopener,noreferrer"
  );
}

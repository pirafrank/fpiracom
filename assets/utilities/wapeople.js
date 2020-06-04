function openChat() {
  var mobile = document.getElementById('mobile').value;
  document.getElementById("mobile").value = '';
  window.open('https://api.whatsapp.com/send?phone=' + mobile, "_blank");
}

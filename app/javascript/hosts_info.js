// 要改修 2022.04.12 t.sema
// http環境ではclipboard APIが使えない
// やむなくexecCommandを使用する


function copyUrl () {
  const copyBtnGuest = document.getElementById("copy_btn_guest");
  const copyBtnHost  = document.getElementById("copy_btn_host");
  copyBtnGuest.addEventListener('click', () => { copyUrlToClipboard('url_guest') });
  copyBtnHost.addEventListener('click', () => { copyUrlToClipboard('url_host') });
}

function copyUrlToClipboard(copyBtnId) {
  const url = document.getElementById(copyBtnId);
  const range = document.createRange();
  range.selectNodeContents(url);
  const selection = window.getSelection();
  selection.removeAllRanges();
  selection.addRange(range);
  
  if(document.execCommand('copy')) {
    selection.removeAllRanges();
  } else {
    alert('コピーに失敗しました。\nCtrl+Cを押してコピーをお願いします.');
  }
}

window.addEventListener('load', copyUrl);

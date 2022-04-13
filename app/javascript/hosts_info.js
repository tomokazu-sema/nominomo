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

// ブラウザ別動作対応
const agent = window.navigator.userAgent.toLowerCase()
if (agent.indexOf('firefox') != -1) {
  // firefoxの場合
  copyUrl();
} else {
  window.addEventListener('load', copyUrl);
}

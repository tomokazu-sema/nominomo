function formBtn() {
  const titleEditBtn = document.getElementById('edit_title');
  let flagTitleEdit = false;
  titleEditBtn.addEventListener('click', () => {
    const formTitleEdit = document.getElementById('form_title');
    if (flagTitleEdit) {
      formTitleEdit.classList.replace('mt-0', 'visually-hidden');
      flagTitleEdit = false;
    } else {
      formTitleEdit.classList.replace('visually-hidden', 'mt-0');
      flagTitleEdit = true;
    }
  });
}

// ブラウザ別動作対応
const agent = window.navigator.userAgent.toLowerCase()
if (agent.indexOf('firefox') != -1) {
  // firefoxの場合
  formBtn();
} else {
  window.addEventListener('load', formBtn);
}

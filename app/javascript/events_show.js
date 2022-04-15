import Form from './form.js'

const classHidden   = 'visually-hidden';
const classUnhidden = 'nomi-dmy';

// イベント名の編集
const formTitleId        = 'form_title';
const openFormTitleId    = 'open_form_title';
const closeFormTitleId   = 'close_form_title';
const submitFormTitleId  = 'submit_form_title';
const messageFormTitleId = 'message_form_title';

const titleId = 'title';

// 開催場所の作成・編集
const formPlaceId        = 'form_place';
const openFormPlaceId    = 'open_form_place';
const closeFormPlaceId   = 'close_form_place';
const submitFormPlaceId  = 'submit_form_place'; 
const messageFormPlaceId = 'message_form_place';

const placeId           = 'place';
const placeUrlDivId     = 'place_url_div';
const placeUrlId        = 'place_url';
const placeCommentDivId = 'place_comment_div';
const placeCommentId    = 'place_comment';

const inputPlaceId        = 'input_place';
const inputPlaceUrlId     = 'input_place_url';
const inputPlaceCommentId = 'input_place_comment';

function formMain() {
  // イベント名の編集
  const formTitle = new Form(formTitleId);
  formTitle.openFormId   = openFormTitleId;
  formTitle.closeFormId  = closeFormTitleId;
  formTitle.submitFormId = submitFormTitleId;
  formTitle.openForm.addEventListener('click', () => { formTitle.openClose() });
  formTitle.closeForm.addEventListener('click', () => { formTitle.close() });
  formTitle.submitForm.addEventListener('click', (e) => {
    formTitle.submit(e);
    formTitle.XHR.addEventListener('load', () => {
      formTitle.onload();
      editHtml(formTitle);
    });
  });
  // 開催場所の作成・編集
  const formPlace = new Form(formPlaceId);
  formPlace.openFormId   = openFormPlaceId;
  formPlace.closeFormId  = closeFormPlaceId;
  formPlace.submitFormId = submitFormPlaceId;
  formPlace.openForm.addEventListener('click', () => { formPlace.openClose() });
  formPlace.closeForm.addEventListener('click', () => { formPlace.close() });
  formPlace.submitForm.addEventListener('click', (e) => {
    formPlace.submit(e);
    formPlace.XHR.addEventListener('load', () => {
      formPlace.onload();
      editHtml(formPlace);
    });
  });
}

function editHtml(form) {
  switch (form.formId) {
    // イベント名の編集
    case formTitleId:
      if (form.messages.length == 0) {
        const title  = document.getElementById(titleId);
        title.textContent = form.model.title;
        deleteMessageList(messageFormTitleId);
      } else {
        insertMessageList(messageFormTitleId, form.messages);
      }
      break;
    // 開催場所の作成・編集
    case formPlaceId:
      if (form.messages.length == 0) {
        const place = document.getElementById(placeId);
        place.textContent = form.model.place;
        const inputPlace = document.getElementById(inputPlaceId);
        inputPlace.value = form.model.place;
        if (form.model.url != '') {
          const urlDiv = document.getElementById(placeUrlDivId);
          urlDiv.classList.replace(classHidden, classUnhidden);
          const url = document.getElementById(placeUrlId);
          url.href = form.model.url;
          const inputPlaceUrl = document.getElementById(inputPlaceUrlId);
          inputPlaceUrl.value = form.model.url;
        }
        if (form.model.comment != '') {
          const commentDiv = document.getElementById(placeCommentDivId);
          commentDiv.classList.replace(classHidden, classUnhidden);
          const comment = document.getElementById(placeCommentId);
          insertStringWithBr(comment, form.model.comment);
          const inputPlaceComment = document.getElementById(inputPlaceCommentId);
          inputPlaceComment.value = form.model.comment;
        }
        deleteMessageList(messageFormPlaced);
      } else {
        insertMessageList(messageFormPlaceId, form.messages);
      }
      break;
  }
}

function insertMessageList(messageId, messages) {
  const message = document.getElementById(messageId);
  for (let i = 0; i < messages.length; i++) {
    const html = `<li>${messages[i]}</li>`;
    message.insertAdjacentHTML('beforeend', html);
  }
}

function deleteMessageList(messageId) {
  const message = document.getElementById(messageId);
  message.innerHTML = ``;
}

function insertStringWithBr(element, str) {
  let html = ``;
  if (str.match(/<script/)) {
    html = `<p class="text-danger">不正な文字列を検出しました</p>`; 
  } else {
    html = `${str.replace(/\r?\n/g, '<br>')}`;
  }
  element.insertAdjacentHTML('beforeend', html);
}

// ブラウザ別動作対応
const agent = window.navigator.userAgent.toLowerCase()
if (agent.indexOf('firefox') != -1) {
  // firefoxの場合
  formMain();
} else {
  window.addEventListener('load', formMain);
}

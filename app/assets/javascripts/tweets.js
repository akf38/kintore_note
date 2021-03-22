$(document).on("keyup", '.tagit', function() {
  
  // Ajaxで、タグ一覧を取得
  let input = $(".ui-widget-content.ui-autocomplete-input").val();  // 変数inputに、入力値を格納
  $.ajax({
    type: 'GET',
    url: 'tag_suggest_tweets',    // ルーティングで設定したurl
    data: { key: input },     // 入力値を:keyとして、コントローラーに渡す
    dataType: 'json'
  })

  .done(function(data){
    if(input.length) {               // 入力値がある時のみ 
      let tag_list = [];             // 空の配列を準備
      data.forEach(function(tag) {   // 取得したdataのnameを配列に格納
        tag_list.push(tag.name);     // 1つずつ追加。 tag_list = ["タグ名1", "タグ名2", ..]
      });
      $(".tag_form").tagit({
        availableTags: tag_list
      });
    }
  })
});
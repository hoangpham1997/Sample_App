$('#micropost_image').bind('change', function() {
  var sizeInMegabytes = this.files[0].size/1024/1024;
  if (sizeInMegabytes > 5) {
    alert(<%= I18n.t('max_file_pls') %>);
  }
});


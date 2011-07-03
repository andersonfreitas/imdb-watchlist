// ===================================
// = Usage: addToMyList("tt1020558") =
// ===================================
addToMyList = function(id) {
  $.ajax({
    url: "/list/_ajax/watchlist_add",
    type: "POST",
    data: {
        tconst: id,
        lcn: "listo"
    },
    error: function () {
        console.log("Error on add");
    },
    success: function (n) {
        if (n.status == 200) {
            console.log("watchlist.added")
        } else console.log("Couldn't add")
    }
  });
};

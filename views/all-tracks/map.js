function(doc) {
    if (doc.type && doc.type == "track") {
        emit(doc.id, {
            artist:doc.artist,
            album:doc.album,
            track:doc.track,
            url:"/couchdj/"+doc._id+"/mp3"
        });
    }
}

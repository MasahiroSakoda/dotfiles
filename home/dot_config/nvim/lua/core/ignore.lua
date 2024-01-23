-- -*-mode:lua-*- vim:ft=lua

return {
  "%.tar$", "%.tar.gz$", "%.tar.xz$", "%.zip$", "%.rar$", "%.7z$", "%.bz2$",
  "^build/", "^dist/", "^.cache/", "%.o$", "%.out$", "%.a$", "%.so$", "%.whl$", "%.bin$",
  "^.git/", "^.svn/", "^.hg/",

  ".DS_Store", "%.dylib", "^.Trashes/",
  "%.exe", "Thumb.db", "desktop.ini",
  ".Trash-*", "^.directory",

  "^.idea/", "^.vscode/", "^.project",
  "^debug/", "^target/",
  "^.gradle/", "^.classpath/", "^.factorypath/", "%.class$", "%.jar$", "%.war$",
  "%.dll$", "%.pdb$",
  "^node_modules/", "^.yarn/", "^.pnpm/", "^.npm/", "package-lock.json",
  "%.min.js$", "%.min.gzip.js$",
  "^.venv/", "%.pyc$", "^__pycache__/", "%.ipynb$",
  "^vendor/", "^deps/",
  "%.sqlite$", "%.sqlite3$", "%.db$",
  "%.lock$",

  "%.ai$", "%.psd$",
  "%.otf$", "%.ttf$", "%.woff$",
  "%.ico$", "%.svg$",
  "%.png$", "%.jpg$", "%.jpeg$", "%.webp$", "%.gif$",
  "%.mp4$", "%.mkv$", "%.m4v$", "%.avi$", "%.flv$",
  "%.wav$", "%.flac$", "%.ttf$", "%.mp3$", "%.m4a$", "%.ogg$",
  "%.doc$", "%.xls$", "%.ppt$", "%.pdf$", "%.epub$",
}

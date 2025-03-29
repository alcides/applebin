import os
import os.path
from pathlib import Path
import re
import shutil
import glob

qdir = Path("/volume1/Queue/")
tvshowdir = Path("/volume1/Media/TV Shows/")


renames = {
    "what if": "What If (2021)",
    "black lotus": "Blade Runner - Black Lotus",
    "the lost symbol": "Dan Brown's The Lost Symbol",
    "new amsterdam": "New Amsterdam (2018)",
    "roswell": "Roswell, New Mexico",
    "star trek discovery": "Star Trek - Discovery",
    "y last man": "Y - The Last Man",
}


def merge(fro, to, target_is_folder: bool):
    try:
        if target_is_folder:
            to.mkdir(parents=True, exist_ok=True)
        else:
            to.parent.mkdir(parents=True, exists_ok=True)
        return Path(shutil.move(str(fro), str(to.resolve())))
    except:
        print(f"Failed {fro} --> {to}")


def wrap(name):
    for k in renames:
        if k in name.lower():
            return renames[k]
    return name


for folder in qdir.glob("*[Ss][0-9][0-9][Ee][0-9][0-9]*"):

    m = re.search("(.*)[Ss]([0-9][0-9])[Ee][0-9][0-9].*", str(folder.name))

    tvshow = m.group(1).replace(".", " ").strip()
    tvshow = wrap(tvshow)
    season = m.group(2)
    target_folder = Path(tvshowdir) / tvshow / f"Season {season}"

    moved = merge(folder, target_folder, True)
    if moved:

        sub_target_folder = moved if moved.is_dir() else target_folder

        possible_subs = target_folder / "Subs" / "2_English.srt"
        if possible_subs.exists():
            newest = max(
                list(target_folder.glob("*.mkv")) + list(target_folder.glob("*.mp4")),
                key=lambda f: f.stat().st_ctime,
            )
            file_name = newest.resolve()
            merge(possible_subs, sub_target_folder / f"{file_name}.srt", False)

for folder in qdir.glob("*[Ss][0-9][0-9]*"):
    m = re.search("(.*)[Ss]([0-9][0-9]).*", str(folder.name))
    tvshow = m.group(1).replace(".", " ").strip()
    tvshow = wrap(tvshow)
    season = m.group(2)
    target_folder = Path(tvshowdir) / tvshow / f"Season {season}"
    merge(folder, target_folder, True)

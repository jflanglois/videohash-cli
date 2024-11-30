from argparse_dataclass import ArgumentParser
from dataclasses import dataclass, field
from functools import partial
from typing import Optional
from validators import url
from videohash import VideoHash

from enum import Enum

class OutputType(Enum):
    hex = "hex"
    binary = "binary"
    debug = "debug"

    def __str__(self):
        return self.value

@dataclass
class Options:
    location: str = field(metadata=dict(args=["location"]))
    storage_path: Optional[str] = None
    keep_intermediaries: bool = False
    download_worst: bool = False
    output: OutputType = field(
            default=OutputType.hex,
            metadata=dict(type=OutputType, choices=list(OutputType)))

def main():
    parser = ArgumentParser(Options)
    options = parser.parse_args()
    video_hash = partial(
            VideoHash,
            storage_path=options.storage_path,
            download_worst=options.download_worst)

    if url(options.location):
        result = video_hash(url=options.location)
    else:
        result = video_hash(path=options.location)

    if not options.keep_intermediaries:
        result.delete_storage_path()

    match options.output:
        case OutputType.hex:
            print(result.hash_hex)
        case OutputType.binary:
            print(result.hash)
        case OutputType.debug:
            print(repr(result))

if __name__ == "__main__":
    main()

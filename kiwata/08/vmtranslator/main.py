import sys
import re

from memonic_parser import (
    Parser,
)

def remove_comments(string):
    pattern = r"(\".*?\"|\'.*?\')|(/\*.*?\*/|//[^\r\n]*$)"
    # first group captures quoted strings (double or single)
    # second group captures comments (//single-line or /* multi-line */)
    regex = re.compile(pattern, re.MULTILINE|re.DOTALL)
    def _replacer(match):
        # if the 2nd group (capturing comments) is not None,
        # it means we have captured a non-quoted (real) comment string.
        if match.group(2) is not None:
            # so we will return empty to remove the comment
            return ''
        # otherwise, we will return the 1st group
        else:
            # captured quoted-string
            return match.group(1)
    return regex.sub(_replacer, string).strip()


def main():
    # Input
    if len(sys.argv) != 2:
        raise ValueError('Invalid file name.')
    input_file_path = sys.argv[1]
    input_texts = get_file_text(input_file_path)
    splited_input_file_path = input_file_path.split('/')
    input_file_name = splited_input_file_path[-1]
    # Output
    output_file_name = '{}.asm'.format(input_file_name.split('.')[0])
    output_file_path = '/'.join([*splited_input_file_path[:-1], output_file_name])
    # Text Processing
    del_commet = lambda value: value[:2] != '//'
    del_new_line = lambda value: value[:2] != '\n'
    replace_new_line = lambda value: value.replace('\n', '').strip()
    input_texts = list(
        map(
            remove_comments, filter(
                del_new_line, filter(del_commet, input_texts)
            )
        )
    )
    # Create Assembler.
    parser = Parser(input_file_name=input_file_name)
    commands = []
    for input_text in input_texts:
        command = parser.get_advance(input_text)
        commands.append(command)
    print(commands)
    create_hack_file(output_file_path, commands)

def get_file_text(file_path):
    with open(file_path) as f:
        return f.readlines()


def create_hack_file(file_path, commands):
    f = open(file_path, 'w')
    for command in commands:
        f.write('\n'.join(command))
        f.write('\n')
    f.close()


if __name__ == '__main__':
    main()

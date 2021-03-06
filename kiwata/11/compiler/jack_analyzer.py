import re
import sys

from compilation_engine import CompilationEngine
from jack_tokenizer import Tokenizer
from vm_writer import VMWriter


def remove_comments(string):
    pattern = r"^(//.*|/\*\*.*\*/|/\*\*.*|\*\s.*|\*/|\s\*\s)$"
    regex = re.compile(pattern, re.MULTILINE | re.DOTALL)
    return not regex.match(string)


def main():
    # Input
    if len(sys.argv) != 2:
        raise ValueError('Invalid file name.')
    input_file_path = sys.argv[1]
    input_texts = get_file_text(input_file_path)
    splited_input_file_path = input_file_path.split('/')
    input_file_name = splited_input_file_path[-1]
    # Output
    output_tokenizer_file_name = '{}.xml'.format(input_file_name.split('.')[0])
    output_tokenizer_file_path = '/'.join([*splited_input_file_path[:-1], output_tokenizer_file_name])
    output_vm_file_name = '{}.vm'.format(input_file_name.split('.')[0])
    output_vm_file_path = '/'.join([*splited_input_file_path[:-1], output_vm_file_name])
    # Text Processing
    del_blank_content = lambda value: value != ''
    del_new_line_in_text = lambda value: value.replace('\n', '')
    # 文中の // を削除して先頭と末尾と空白の文字列を削除
    del_comment_in_line = lambda string: re.sub(r'//\s.*', '', string).strip()
    input_texts = list(
        filter(
            del_blank_content, map(
                del_comment_in_line, filter(
                    remove_comments, map(
                        del_new_line_in_text, input_texts
                    )
                )
            )
        )
    )
    update_input_texts = []
    for input_text in input_texts:
        # プログラム中のコメントアウト (/** */) は上のテキスト処理では削除できないのでこの処理を追加
        if remove_comments(input_text):
            update_input_texts.append(input_text)

    print('output_tokenizer_file_name: {}'.format(output_tokenizer_file_name))
    print('output_vm_file_name: {}'.format(output_vm_file_name))
    with VMWriter(output_vm_file_path) as vmw:
        with CompilationEngine(update_input_texts, output_tokenizer_file_path, vmw) as engine:
            engine.compile()


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

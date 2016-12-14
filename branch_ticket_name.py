#!/usr/bin/python3

"""
From: https://git-scm.com/book/en/v2/Customizing-Git-Git-Hooks

The commit-msg hook takes one parameter, which again is the path to a
temporary file that contains the commit message written by the developer.
If this script exits non-zero, Git aborts the commit process, so you can use
it to validate your project state or commit message before
allowing a commit to go through.

argv[1]: path to the temp file where to write the commit message
"""

import subprocess
import sys


def current_branch_name():
    return subprocess.check_output(
        ('git', 'rev-parse', '--abbrev-ref', 'HEAD')).decode().strip('\n')


def ticket_name(branch_name):
    """
    Assume the naming convention <ticket_no><underscore><description>
    and return <ticket_no>

    Where: <underscore>  -> "_"

    The delimiter is an <underscore>
    In case this is not respected it will return the token
    up to the first <underscore>, or everything if none is found.

    :param str branch_name: name of the branch we are currently in
    :return: ticket number from the branch
    """
    ticket_no, _, _ = branch_name.partition("_")
    return ticket_no


def ticket_from_branch():
    return ticket_name(current_branch_name())


def header():
    """
    Return the string that will compose the header of the commit msg
    """
    ticket = ticket_from_branch()
    return """{0}:""".format(ticket)


def write_commit_msg_template(commit_msg_file, header, content):
    """
    :param file commit_msg_file: the file where to dump the new content
    :param str header:           the first line (title) in the commit msg
    :param str content:          Original content from the base template of the
                                 commit msg.
    """
    if header not in content:
        commit_msg_file.write(header)
    commit_msg_file.write(content)


if __name__ == '__main__':
    with open(sys.argv[1], "r") as original:
        content = original.read()

    with open(sys.argv[1], "w") as commit_msg_file:
        write_commit_msg_template(commit_msg_file, header(), content)

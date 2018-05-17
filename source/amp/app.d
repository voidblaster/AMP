﻿/++
    This file is part of AMP - API Markup Processor.
    Copyright (c) 2018  R3Vid
    Copyright (c) 2018  0xEAB

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU Affero General Public License as
    published by the Free Software Foundation, either version 3 of the
    License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU Affero General Public License for more details.

    You should have received a copy of the GNU Affero General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
 +/
module amp.app;

import std.file : exists, isDir;
import std.getopt;
import std.stdio;

import amp.parser;

/++
    Launches AMP in command-line mode
 +/
int runCLI(string[] args)
{
    bool optPrintVersionInfo;

    GetoptResult rgetopt = getopt(
        args,
        config.passThrough,
        "version|w", "Display the version of this program", &optPrintVersionInfo
    );

    if (rgetopt.helpWanted)
    {
        defaultGetoptPrinter(import("appname.txt") ~ "\n\n  Usage:\n    " ~ args[0] ~
            " [options] [blueprint path]\n\n\nAvailable options:\n==================", rgetopt.options);
        return 0;
    }
    else if (optPrintVersionInfo)
    {
        printVersionInfo();
        return 0;
    }

    // Blueprint path passed?
    if (args.length < 2)
    {
        // no
        stderr.writeln("Error: No blueprint path specified");
        return 1;
    }

    string path = args[$-1];

    // Verify path
    if (!exists(path))
    {
        stderr.writeln("Error: Non-existant blueprint path (" ~ path ~ ")");
        return 1;
    }

    // Determine path type (dir or file)
    if (isDir(path))
    {
        // Directory
        assert(0, "Not implemented");
    }
    else
    {
        // File
        ParserResult r = parseBlueprint(path);
    }

    return 0;
}

/++
    Prints AMP's version string
 +/
void printVersionInfo()
{
    writeln("AMP v", import("version.txt"));
}
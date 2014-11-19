precc
=====

precc is a pre-processor for coffeescript. It allows to include other coffee-script files with proper indentation handling.

# Syntax

To include another file into your script, use the following command:

```coffee
#_include filename
```

This includes the file ```filename.coffee``` at the current position.

## Indentation handling

Assume you have the following script:

```coffee
multiply = (x, y) ->
  #_include method
```

and ```method.coffee``` contains:

```coffee
x * y
```

then the result is:

```coffee
multiply = (x, y) ->
  #----------------------------------------------------------------------------#
  # from <./method.coffee>
  x * y
  #----------------------------------------------------------------------------#
```

# Usage

precc comes as a command-line tool called `precc`. Invoked without any argument, it reads from standard input. Multiple files as arguments are concatenated together.

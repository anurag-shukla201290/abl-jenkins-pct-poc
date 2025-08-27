/* src/HelloWorld.cls */
USING Progress.Lang.*.

CLASS HelloWorld:
  METHOD PUBLIC STATIC VOID SayHello():
    MESSAGE "Hello, World from an ABL CLASS!" VIEW-AS ALERT-BOX INFO.
  END METHOD.
END CLASS.

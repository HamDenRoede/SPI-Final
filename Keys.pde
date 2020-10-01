class Keys
{
  //wasd
  private boolean wDown = false;
  private boolean aDown = false;
  private boolean sDown = false;
  private boolean dDown = false;

  //arrow keys
  private boolean upDown = false;
  private boolean leftDown = false;
  private boolean downDown = false;
  private boolean rightDown = false;  


  public Keys() {
  }

  public boolean wDown()
  {
    return wDown;
  }

  public boolean aDown()
  {
    return aDown;
  }

  public boolean sDown()
  {
    return sDown;
  }

  public boolean dDown()
  {
    return dDown;
  }

  public boolean upDown()
  {
    return upDown;
  }

  public boolean leftDown()
  {
    return leftDown;
  }

  public boolean downDown()
  {
    return downDown;
  }

  public boolean rightDown()
  {
    return rightDown;
  }



  void onKeyPressed(char ch)
  {
    if (ch == 'W' || ch == 'w' )
    {
      wDown = true;
    } else if (ch == 'A' || ch == 'a' )
    {
      aDown = true;
    } else if (ch == 'S' || ch == 's' )
    {
      sDown = true;
    } else if (ch == 'D' || ch == 'd' )
    {
      dDown = true;
    }
    //adding arrowkeys
    if (key == CODED)
    {
      if (keyCode == UP)
      {
        upDown = true;
      }
    }
    if (key == CODED)
    {
      if (keyCode == LEFT)
      {
        leftDown = true;
      }
      if (key == CODED)
      {
        if (keyCode == DOWN)
        {
          downDown = true;
        }
      }
      if (key == CODED)
      {
        if (keyCode == RIGHT)
        {
          rightDown = true;
        }
      }
    }
  }






    void onKeyReleased(char ch)
    {
      if (ch == 'W' || ch == 'w' )
      {
        wDown = false;
      } else if (ch == 'A' || ch == 'a' )
      {
        aDown = false;
      } else if (ch == 'S' || ch == 's' )
      {
        sDown = false;
      } else if (ch == 'D' || ch == 'd' )
      {
        dDown = false;
      }
      //Adding arrowkeys
      if (key == CODED)
      {
        if (keyCode == UP)
        {
          upDown = false;
        }
      }
      if (key == CODED)
      {
        if (keyCode == LEFT)
        {
          leftDown = false;
        }
      }
      if (key == CODED)
      {
        if (keyCode == DOWN)
        {
          downDown = false;
        }
      }
      if (key == CODED)
      {
        if (keyCode == RIGHT)
        {
          rightDown = false;
        }
      }
    }
  }

import java.util.Random;

class Game
{
  private Random rnd;
  private final int width;
  private final int height;
  private int[][] board;
  private Keys keys;
  private int playerLife;
  private Dot player;
  
  //adding a Dot for player two
  private Dot playerTwo;
  private int playerTwoLife;
  
  private Dot[] enemies;

  //adding a food array
  private Dot[] food;


  //Im adding my food into the game function

  Game(int width, int height, int numberOfEnemies, int numberOfFood)
  {
    if (width < 10 || height < 10)
    {
      throw new IllegalArgumentException("Width and height must be at least 10");
    }
    if (numberOfEnemies < 0)
    {
      throw new IllegalArgumentException("Number of enemies must be positive");
    } 
    //Adding an illegal argument for lack of food variable
    if (numberOfFood < 0)
    {
      throw new IllegalArgumentException("Ammount of Food must be positive");
    }
    this.rnd = new Random();
    this.board = new int[width][height];
    this.width = width;
    this.height = height;
    keys = new Keys();
    player = new Dot(0, 0, width-1, height-1); 
    //adding a new Dot for player two, with a slighty different spawnpoint. 
    playerTwo = new Dot (0, 1, width-1, height-1);
    enemies = new Dot[numberOfEnemies];
    for (int i = 0; i < numberOfEnemies; ++i)
    {
      enemies[i] = new Dot(width-1, height-1, width-1, height-1);
    }
    food = new Dot[numberOfFood];
    for (int i = 0; i < numberOfFood; ++i)
    {
      food[i] = new Dot (width-1, height-1, width-1, height-1);
    }
    for (int i = 0; i <numberOfFood; ++i)
    {
      int startX = int(random(width-1));
      int startY = int(random(height-1));
      food[i] = new Dot(startX, startY, width-1, height-1);
    }
    this.playerLife = 100;
    this.playerTwoLife = 100;
  }

  public int getWidth()
  {
    return width;
  }

  public int getHeight()
  {
    return height;
  }

  public int getPlayerLife()
  {
    return playerLife;
  }
  
  //adding a "gePlayerLife" for player two
  
  public int getPlayerTwoLife()
  {
    return playerTwoLife;
  }

  public void onKeyPressed(char ch)
  {
    keys.onKeyPressed(ch);
  }

  public void onKeyReleased(char ch)
  {
    keys.onKeyReleased(ch);
  }



  public void update()
  {
    updatePlayer();
    //Adding arrowkey controls for player two
    updatePlayerTwo();
    updateEnemies();
    //once again, adding a function for food
    updateFood();
    checkForCollisions();
    clearBoard();
    populateBoard();
  }



  public int[][] getBoard()
  {
    //ToDo: Defensive copy?
    return board;
  }

  private void clearBoard()
  {
    for (int y = 0; y < height; ++y)
    {
      for (int x = 0; x < width; ++x)
      {
        board[x][y]=0;
      }
    }
  }

  private void updatePlayer()
  {
    //Update player
    if (keys.wDown() && !keys.sDown())
    {
      player.moveUp();
    }
    if (keys.aDown() && !keys.dDown())
    {
      player.moveLeft();
    }
    if (keys.sDown() && !keys.wDown())
    {
      player.moveDown();
    }
    if (keys.dDown() && !keys.aDown())
    {
      player.moveRight();
    }
  }

 private void updatePlayerTwo()
  {
    //Update player two
    if (keys.upDown() && !keys.downDown())
    {
      playerTwo.moveUp();
    }
    if (keys.leftDown() && !keys.rightDown())
    {
      playerTwo.moveLeft();
    }
    if (keys.downDown() && !keys.upDown())
    {
      playerTwo.moveDown();
    }
    if (keys.rightDown() && !keys.leftDown())
    {
      playerTwo.moveRight();
    }
  }


  //rearanging the updateEnemies to make it work for food instead.

  private void updateFood()
  {
    for (int i = 0; i < food.length; ++i)
    {
      if (rnd.nextInt(3) < 2)
      {
        //This time, we want the food to run away from the players
        int dx = player.getX() - food[i].getX();
        int dy = player.getY() - food[i].getY();
        int ax = playerTwo.getX() - food[i].getX();
        int ay = playerTwo.getY() - food[i].getY();
        if (abs(dx) > abs(dy))
        if (abs(ax) > abs(ay))
        {
          if (dx > 0 || ax > 0)
          {
            //Player is to the right
            food[i].moveLeft();
          } else
          {
            //Player is to the left
            food[i].moveRight();
          }
        } else if (dy > 0 || ay > 0)
        {
          //Player is down;
          food[i].moveUp();
        } else
        {//Player is up;
          food[i].moveDown();
        }
      } else
      {
        //We move randomly
        int move = rnd.nextInt(4);
        if (move == 0)
        {
          //Move right
          food[i].moveRight();
        } else if (move == 1)
        {
          //Move left
          food[i].moveLeft();
        } else if (move == 2)
        {
          //Move up
          food[i].moveUp();
        } else if (move == 3)
        {
          //Move down
          food[i].moveDown();
        }
      }
    }
  }

  private void updateEnemies()
  {
    for (int i = 0; i < enemies.length; ++i)
    {
      //Should we follow or move randomly?
      //2 out of 3 we will follow..
      if (rnd.nextInt(3) < 2)
      {
        //We follow
        int dx = player.getX() - enemies[i].getX();
        int dy = player.getY() - enemies[i].getY();
        int ax = playerTwo.getX() - enemies[i].getX();
        int ay = playerTwo.getX() - enemies[i].getY();
        if (abs(dx) > abs(dy))
        if (abs(ax) > abs(ay))
        {
          if (dx > 0 || ax > 0)
          {
            //Player is to the right
            enemies[i].moveRight();
          } else
          {
            //Player is to the left
            enemies[i].moveLeft();
          }
        } else if (dy > 0 || ay > 0)
        {
          //Player is down;
          enemies[i].moveDown();
        } else
        {//Player is up;
          enemies[i].moveUp();
        }
      } else
      {
        //We move randomly
        int move = rnd.nextInt(4);
        if (move == 0)
        {
          //Move right
          enemies[i].moveRight();
        } else if (move == 1)
        {
          //Move left
          enemies[i].moveLeft();
        } else if (move == 2)
        {
          //Move up
          enemies[i].moveUp();
        } else if (move == 3)
        {
          //Move down
          enemies[i].moveDown();
        }
      }
    }
  }

  private void populateBoard()
  {
    //Insert player
    board[player.getX()][player.getY()] = 1;
    //insert player 2
    board[playerTwo.getX()][playerTwo.getY()] = 4;
    //Insert enemies
    for (int i = 0; i < enemies.length; ++i)
    {
      board[enemies[i].getX()][enemies[i].getY()] = 2;
    }
    //Insert food
    for (int i = 0; i < food.length; ++i)
    {
      board[food[i].getX()][food[i].getY()] = 3;
    }
  }

  private void checkForCollisions()
  {
    //Check enemy collisions
    for (int i = 0; i < enemies.length; ++i)
    {
      if (enemies[i].getX() == player.getX() && enemies[i].getY() == player.getY())
      {
        //We have a collision
        --playerLife;
      }
      if (enemies[i].getX() == playerTwo.getX() && enemies[i].getY() == playerTwo.getY())
      {
        //we have a collision for player two
        --playerTwoLife;
      }
    }
    //Check food collisions
    for (int i = 0; i < food.length; ++i)
    {
      if (food[i].getX() == player.getX() && food[i].getY() == player.getY())
      {
        //food collision will cause an uptic in life
        ++playerLife;
        food[i].setX(rnd.nextInt(width-1));
        food[i].setY(rnd.nextInt(height-1));
      }
      //Here I'm ensuring that the players life does not exceed 100.
      if (playerLife == 101)
      {
        --playerLife;
      }
      if (food[i].getX() == playerTwo.getX() && food[i].getY() == playerTwo.getY())
      {
        //food collision will cause an uptic in life for player two
        ++playerTwoLife;
        food[i].setX(rnd.nextInt(width-1));
        food[i].setY(rnd.nextInt(height-1));
      }
      //Here I'm ensuring that player two's life does not exceed 100.
      if (playerTwoLife == 101)
      {
        --playerTwoLife;
  }
}
}
}

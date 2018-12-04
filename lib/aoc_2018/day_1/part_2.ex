defmodule AOC2018.Day1.Part2 do
  @moduledoc ~S"""
  --- Part Two ---

  You notice that the device repeats the same frequency change list over and over. To calibrate the device, you need to find the first frequency it reaches twice.

  For example, using the same list of changes above, the device would loop as follows:

    * Current frequency  0, change of +1; resulting frequency  1.
    * Current frequency  1, change of -2; resulting frequency -1.
    * Current frequency -1, change of +3; resulting frequency  2.
    * Current frequency  2, change of +1; resulting frequency  3.
    * (At this point, the device continues from the start of the list.)
    * Current frequency  3, change of +1; resulting frequency  4.
    * Current frequency  4, change of -2; resulting frequency  2, which has already been seen.

  In this example, the first frequency reached twice is 2. Note that your device might need to repeat its list of frequency changes many times before a duplicate frequency is found, and that duplicates might be found while in the middle of processing the list.

  Here are other examples:

    * +1, -1 first reaches 0 twice.
    * +3, +3, +4, -2, -4 first reaches 10 twice.
    * -6, +3, +8, +5, -6 first reaches 5 twice.
    * +7, +7, -2, -7, -4 first reaches 14 twice.

  What is the first frequency your device reaches twice?


  ## Examples

      iex> AOC2018.Day1.Part2.solve("+1\n-1")
      0

      iex> AOC2018.Day1.Part2.solve("+3\n+3\n+4\n-2\n-4")
      10

      iex> AOC2018.Day1.Part2.solve("-6\n+3\n+8\n+5\n-6")
      5

      iex> AOC2018.Day1.Part2.solve("+7\n+7\n-2\n-7\n-4")
      14
  """

  @doc """
  Takes `input` as a string with changes split by newline.

  Returns the first `frequency` reached twice as integer.
  """
  @spec solve(String.t()) :: integer
  def solve(input) do
    String.split(input, "\n")
    |> Enum.map(&String.to_integer/1)
    |> Stream.cycle()
    |> Enum.reduce_while([0], fn change, history ->
      next = Enum.at(history, -1) + change

      if Enum.member?(history, next) do
        {:halt, next}
      else
        {:cont, history ++ [next]}
      end
    end)
  end
end

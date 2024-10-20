puts '戦争を開始します'
class Card
  def initialize
    # カードのランクを定義
    @card_ranks = {
      'A' => 14, 'K' => 13, 'Q' => 12, 'J' => 11, '10' => 10, '9' => 9,
      '8' => 8, '7' => 7, '6' => 6, '5' => 5, '4' => 4, '3' => 3, '2' => 2,
    }
  end

  # デッキを作成するメソッドを作成
  def deck_creation
    # card_typesを作成しそれぞれのタイプを配列に追加
    card_types = ['ダイヤ', 'ハート', 'スペード', 'クローバー']

    # @card_ranksインスタンス変数を.keysで配列を全て取得
    ranks = @card_ranks.keys

    # prodcutメソッドをmapメソッドを使用し、ranksとcard_typesを組み合わせた新たな配列の作成
    deck = ranks.product(card_types).map do |rank, type|
      [rank, type]
    end

    # deckの配列をshuffleメソッドを使用し、シャッフル
    deck.shuffle
  end

  # deck_creationメソッドのdeckを配るメソッドの作成
  def deck_deal(deck)
    # deckを二つに分ける
    [deck[0..25], deck[26..51]]
  end

  # カードの強さを比較するメソッドを作成
  def card_strength(card1, card2)
    # カードのランクを取得する
    rank1 = card1[0]
    rank2 = card2[0]

    # 条件分岐を使ってカードの強さを比較する
    # カード1が強い場合
    if @card_ranks[rank1] > @card_ranks[rank2]
      card1
    # カード2が強い場合
    elsif @card_ranks[rank1] < @card_ranks[rank2]
      card2
    # 引き分けの場合
    else
      nil
    end
  end
end

class Player
  # プレイヤーの名前と手札を作成
  def initialize(name, hand)
    @name = name
    @hand = hand
  end

  # 名前を取得するメソッド
  def get_name
    @name
  end

  # 手札の枚数を把握するメソッド
  def count_card
    # lengthメソッドを使い配列を展開
    @hand.length
  end

  # 手札からカードを出すメソッド
  def play_card
    # 最初のカードを取り出す
    @hand.shift
  end

  # 勝ったらカードをもらうメソッド
  def get_cards(cards)
    # concatメソッドを使って配列の結合をカードをシャッフル
    @hand.concat(cards.shuffle)
  end

  # 手札を持っているかどうかのメソッド
  def has_cards?
    # lengthメソッドを使い配列を展開
    @hand.length > 0
  end
end

class WarGame
  # ゲームを初期化する
  def initialize
    # Cardクラスのインスタンスを作成してデッキを作成
    @card_game = Card.new
    @deck = @card_game.deck_creation
    @player1, @player2 = create_players
  end

  # プレイヤーを作成しデッキを配布するメソッド
  def create_players
    # deck_dealメソッドを使ってデッキを分ける
    player1_deck, player2_deck = @card_game.deck_deal(@deck)

    # Playerクラスのインスタンスを作成して。それぞれのプレイヤーに渡す
    player1 = Player.new("プレイヤー1", player1_deck)
    player2 = Player.new("プレイヤー2", player2_deck)
    puts "カードが配られました。"
    [player1, player2]
  end

  # ラウンドをプレイするメソッドを作成
  def play_round
    # 各プレイヤーがまだ手札を持っているかどうかをチェックするループする
    while @player1.has_cards? && @player2.has_cards?
      puts "戦争！"

      # 各プレイヤーがデッキから1枚カードを出す
      card1 = @player1.play_card
      card2 = @player2.play_card

      puts "#{@player1.get_name}のカードは#{card1[1]}の#{card1[0]}です。"
      puts "#{@player2.get_name}のカードは#{card2[1]}の#{card2[0]}です。"

      # 勝敗を判定するメソッドを呼び出し、勝者を判定する
      determine_winner(card1, card2)

      puts "#{@player1.get_name}の残りカード数: #{@player1.count_card}"
      puts "#{@player2.get_name}の残りカード数: #{@player2.count_card}"
    end

    # 全てのラウンドが終了したら、勝者を宣言
    declare_winner
  end

  # カードを比較して勝者を決めるメソッドを作成
  def determine_winner(card1, card2, pile: [card1, card2])
    # card_strngthメソッドを呼び出して、どちらかのカードが強いかを取得する
    winner_card = @card_game.card_strength(card1, card2)

    # 各プレイヤーが勝った場合の条件分岐
    # プレイヤー1が勝った場合
    if winner_card == card1
      puts "#{@player1.get_name}が勝ちました。"
      # 勝者のプレイヤーの手札にこのラウンドのカード(pile)を追加
      @player1.get_cards(pile)
    # プレイヤー2が勝った場合
    elsif winner_card == card2
      puts "#{@player2.get_name}が勝ちました。"
      @player2.get_cards(pile)
    else
      puts "引き分けです。戦争！"

      # 両方のプレイヤーがまだカードを持っているか確認
      if @player1.has_cards? && @player2.has_cards?
        # 各プレイヤーが1枚づつカードを引く
        new_card1 = @player1.play_card
        new_card2 = @player2.play_card

        # pileに新たに引いたカードを追加
        pile.concat([new_card1, new_card2])
        puts "#{@player1.get_name}のカードは#{new_card1[1]}の#{new_card1[0]}です。"
        puts "#{@player2.get_name}のカードは#{new_card2[1]}の#{new_card2[0]}です。"

        # 再帰的にdeterine_winnerを呼び出し、新しいカードで勝敗を決定
        determine_winner(new_card1, new_card2, pile: pile)
      else
        # プレイヤー1がカードを持っていない場合
        if !@player1.has_cards?
          puts "#{@player1.get_name}のカードが尽きました。#{@player2.get_name}の勝利です。"
        # プレイヤー2がカードを持っていない場合
        elsif !@player2.has_cards?
          puts "#{@player2.get_name}のカードが尽きました。#{@player1.get_name}の勝利です。"
        end
      end
    end
  end

  # ゲーム終了後に最終的な勝者を発表するメソッドする
  def declare_winner
    puts '戦争を終了します。'
    # プレイヤー1のカード枚数が多ければプレイヤー1が勝利
    if @player1.count_card > @player2.count_card
      puts "#{@player1.get_name}が勝ちました！"
      puts "#{@player1.get_name}の手札の枚数は#{@player1.count_card}枚です。"
      puts "#{@player2.get_name}の手札の枚数は#{@player2.count_card}枚です。"
      puts "#{@player1.get_name}が1位、#{@player2.get_name}が2位です。"

    # プレイヤー2のカード枚数が多ければプレイヤー2が勝利
    elsif @player2.count_card > @player1.count_card
      puts "#{@player2.get_name}が勝ちました！"
      puts "#{@player2.get_name}の手札の枚数は#{@player2.count_card}枚です。"
      puts "#{@player1.get_name}の手札の枚数は#{@player1.count_card}枚です。"
      puts "#{@player2.get_name}が1位、#{@player1.get_name}が2位です。"
    else
      puts "引き分けです！"
    end
  end
end

# WerGameクラスのインスタンスを作成し、ゲームを開始
game = WarGame.new
game.play_round

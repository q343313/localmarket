import 'package:localmarket/allpaths.dart';
import '../../../../config/components/favorteproduct.dart';

class FavoriteScreen extends ConsumerStatefulWidget {
  const FavoriteScreen({super.key});

  @override
  ConsumerState<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends ConsumerState<FavoriteScreen> {
  TextEditingController searchcontroller = TextEditingController();

  @override
  void dispose() {
    searchcontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userdata = ref.watch(favoriteProvider.select((val) => val.favorites));
    return GestureDetector(
        onTap: () {
      FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text("Favorite"),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              SizedBox(height: 20),
              CustomTextfieldWidget(
                label: "Search",
                preffixicon: Icons.search,
                controller: searchcontroller,
                onChanged: (value) =>
                    ref.read(favoriteProvider.notifier).searchvalue(value),
              ),
              SizedBox(height: 20),
              Expanded(
                child: userdata.isEmpty
                    ? Center(
                  child: Text(
                    "No Favorite Product ",
                    style:
                    TextStyle(fontSize: 20, fontFamily: "title"),
                  ),
                )
                    : GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                  childAspectRatio:0.76,                  children: userdata
                      .map((e) => buildFavorProductCard(context, e))
                      .toList(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}



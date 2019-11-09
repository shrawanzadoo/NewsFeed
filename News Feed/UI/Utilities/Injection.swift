import Foundation

class Injection {
    static let shared = Injection()
    
    public let newsFeedPresenter = NewsFeedPresenter(scheduler: AppSchedulerProvider(), getPostsUseCase: GetPosts(postsRepository: PostsRepositoryImpl()), getUsersUseCase: GetUsers(usersRepository: UsersRepositoryImpl()), getCommentsUseCase: GetComments(commentsRepository: CommentsRepositoryImpl()))
}
